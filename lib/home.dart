import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notify/notify.dart';
import 'package:notify/size_config.dart';
import 'package:notify/tasklists.dart';
import 'add_task_page.dart';
import 'button.dart';
import 'notification_screen.dart';
import 'riverpod_task.dart';
import 'sql.dart';
import 'task.dart';
import 'theme.dart';
import 'theme_services.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late Future<void> load_tasks;
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    load_tasks = ref.watch(Tasks_list_Provider.notifier).loadtasks(DateFormat.yMd().format(_selectedDate));
     List<Task> Tasks = ref.watch(Tasks_list_Provider);
    return Scaffold(
      appBar:_appbar(),
      body: SafeArea(
        child: Column(
          children: [
            _first(),
            _second(),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: load_tasks,
                builder:
                    ( context,  snapshot) =>
                        // snapshot.connectionState == ConnectionState.done
                            snapshot.hasData
                            //   snapshot.hasError
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            :
                        TaskLists(
                                TasksLists: Tasks,
                              )
            ),
          ],
        ),
      ),
    );
  }

  _appbar() {
    return AppBar(
      leading: IconButton(
        onPressed: () async {
          ThemeServices().switchTheme();
        },
        icon: Icon(
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
          size: 24,
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
      ),
      elevation: 0,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      actions: [
        IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context)=>AlertDialog(title: Text("You will delete all the notes"),
              actions: [ElevatedButton(onPressed: (){
              ref.watch(Tasks_list_Provider.notifier).delete_tasks();
              LocalNotifictionServiece.flutterLocalNotificationsPlugin.cancelAll();
              Get.back();
              }, child: Text("Ok")),
              ElevatedButton(onPressed: (){
                Get.back();
              }, child: Text("Don't"))],
              ));
            },
            icon: Icon(
              Icons.cleaning_services_outlined,
              size: 24,
              color: Get.isDarkMode ? Colors.white : darkGreyClr,
            )),
        const CircleAvatar(
          backgroundImage: AssetImage('assets/person.jpeg'),
          radius: 18,
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  _first() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${DateFormat.yMMMMd().format(DateTime.now())}",
                  style: Themes().haedingstyle),
              Text('Today', style: Themes().haedingstyle),
            ],
          ),
          MyButton(
            label: '+ Add Task',
            onTap: () async {
              // Get.to(()=>NotificationScreen(payload:"the title|the date|the discription|09:25 AM|10:48 PM|Weekly|15|1|0"));
              await Get.to(() => const AddTaskPage());
            },
          ),
        ],
      ),
    );
  }

  _second() {
   return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (newDate) => setState(() {
          _selectedDate = newDate;
          // ref.watch(Tasks_list_Provider.notifier).reloadtasks(_selectedDate);
        }),
      ),
    );
  }
}

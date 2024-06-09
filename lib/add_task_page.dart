import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notify/notify.dart';
import 'package:notify/sql.dart';
import 'riverpod_task.dart';
import 'task.dart';
import 'button.dart';
import 'input_field.dart';
import 'theme.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay start=TimeOfDay.now();
  TimeOfDay end=TimeOfDay.now();

  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Hourly','Monthly'];

  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: primaryClr,
          ),
        ),
        elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/person.jpeg'),
            radius: 18,
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Add Task', style: Themes().bodystyle),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                mywidget: IconButton(
                  onPressed: () async{
                    FocusScope.of(context).unfocus();
                 var timed= await  showDatePicker(context: context, firstDate: DateTime.now(),
                     lastDate:DateTime.now().add(Duration(days:366)) );
                    if(timed!=null){
                      setState(() {
                    _selectedDate=timed;
                      });
                    }
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      mywidget: IconButton(
                        onPressed: ()async {
                          FocusScope.of(context).unfocus();
                          var timeend=   await  showTimePicker(context: context, initialTime: TimeOfDay.now(),);
                          if(timeend!=null){
                          start= timeend;
                            setState(() {
                              _startTime = timeend.format(context);
                            });
                          }

                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      mywidget: IconButton(
                        onPressed: () async{
                          FocusScope.of(context).unfocus();
                     var timeend=   await  showTimePicker(context: context, initialTime: TimeOfDay.now(),);

                          if(timeend!=null){
                            end=timeend;
                            setState(() {
                              _endTime = timeend.format(context);
                            });
                          }


                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                mywidget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: remindList
                          .map<DropdownMenuItem<String>>(
                            (int value) => DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text('$value',
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      )
                          .toList(),
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.grey),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(height: 0),
                      style: Themes().substyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ),
              InputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                mywidget: Row(
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: repeatList
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      )
                          .toList(),
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: Colors.grey),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(height: 0),
                      style: Themes().substyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                    label: 'Create Task',
                    onTap: () async{
                      bool check= false;

                       if(start.hour> end.hour){
                         check=false;
                       }else{
                         if(start.hour==end.hour &&start.minute>=end.minute){
                           check=false;
                         }else {
                           check=true;
                         }
                       }


                    if(check==true&&_titleController.text.trim().isNotEmpty&&_noteController.text.trim().isNotEmpty){
                     DateTime single= _selectedDate.add(Duration(hours: start.hour,minutes: start.minute));

                     ref.watch(Tasks_list_Provider.notifier).add_task(
                     title:_titleController.text,
                     note: _noteController.text,
                     date: DateFormat.yMd().format(_selectedDate).toString(),
                     repeat:_selectedRepeat,
                     remind: _selectedRemind,
                     color: _selectedColor,
                     end: end,
                     endtime:_endTime,
                     iscompleted:0,
                     start: start,
                     starttime:_startTime,
                     time:_selectedDate,
                     );
                     Get.back();

                    }else{
                      String mass=check==false?"Enter end time larger than start time please":
                      "Enter  the title and the note fields  please";
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: Text(mass),
                          actions: [ElevatedButton(onPressed: (){
                            Get.back();
                          }, child: Text("Ok"))],
                        );
                      });
                    }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: Themes().haedingstyle),
        const SizedBox(height: 8),
        Wrap(
          children: List<Widget>.generate(
            3,
                (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  child: _selectedColor == index
                      ? const Icon(Icons.done, size: 16, color: Colors.white)
                      : null,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                      ? pinkClr
                      : orangeClr,
                  radius: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

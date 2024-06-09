import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:notify/notify.dart';
import 'package:notify/riverpod_task.dart';

import 'size_config.dart';
import 'sql.dart';
import 'task.dart';
import 'task_tile.dart';
import 'theme.dart';

class TaskLists extends ConsumerStatefulWidget {
  TaskLists({super.key, required this.TasksLists});
  List<Task> TasksLists;
  @override
  ConsumerState<TaskLists> createState() => _TaskListsState();
}

class _TaskListsState extends ConsumerState<TaskLists> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return widget.TasksLists.isEmpty?svgtask():
    Expanded(
      child: ListView.builder(
        scrollDirection: SizeConfig.orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: 500),
            child: SlideAnimation(
              horizontalOffset: 300,
              child: FadeInAnimation(
                duration: Duration(seconds: 1),
                child: GestureDetector(
                    onTap: () {
                      showBottomSheet(context, widget.TasksLists[index],widget.TasksLists[index].id,
                          index);
                    },
                    child: TaskTile(widget.TasksLists[index])),
              ),
            ),
          );
        },
        itemCount: widget.TasksLists.length,
      ),
    );
  }

  showBottomSheet(BuildContext context, Task task,int? id ,int index) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.30
                  : SizeConfig.screenHeight * 0.39),
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      label: 'Task Completed',
                      onTap: () async {
                        ref.watch(Tasks_list_Provider.notifier).updatetask(task,id!);
                        LocalNotifictionServiece.flutterLocalNotificationsPlugin
                            .cancel(id);
                        if(task.repeat!="None"&&task.repeat!="Monthly"){
                          LocalNotifictionServiece.flutterLocalNotificationsPlugin
                              .cancel((-task.id!));
                        }
                        Get.back();
                      },
                      clr: primaryClr,
                    ),
              _buildBottomSheet(
                label: 'delete Task',
                onTap: () async {
                ref.watch(Tasks_list_Provider.notifier).deleteSingletask(task.id);

             LocalNotifictionServiece.flutterLocalNotificationsPlugin
                      .cancel(id!);
                  if(task.repeat!="None"||task.repeat=="Monthly"){
                    LocalNotifictionServiece.flutterLocalNotificationsPlugin
                        .cancel((-task.id!));
                  }
                  Get.back();
                },
                clr: Colors.red,
              ),
              Divider(color: Get.isDarkMode ? Colors.grey : darkGreyClr),
              _buildBottomSheet(
                label: 'Cancel',
                onTap: () {
                  Get.back();
                },
                clr: primaryClr,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _buildBottomSheet(
      {required String label,
      required Function() onTap,
      required Color clr,
      bool isClose = false,}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey
                    // [600]!
                    : Colors.grey
                // [300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? Themes().body2style
                : Themes().body2style.copyWith(
                      color: Colors.white,
                    ),
          ),
        ),
      ),
    );
  }

  svgtask() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            curve: Curves.bounceOut,
            child: SingleChildScrollView(
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? SizedBox(
                          height: 6,
                        )
                      : SizedBox(
                          height: 100,
                        ),
                  SvgPicture.asset(
                    "assets/task.svg",
                    fit: BoxFit.fill,
                    height: 80,
                    alignment: Alignment.center,
                    // color: Get.isDarkMode ? Colors.teal : Colors.blueGrey,
                  ),
                  Center(
                    child: Text("No Tasks"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

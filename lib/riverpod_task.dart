import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notify/notify.dart';
import 'sql.dart';
import 'task.dart';


class Place_provider extends StateNotifier<List<Task>> {
  Place_provider() : super([]);
  
  Future<void> loadtasks(String date) async {
    sql mysql = sql();
    final List<Map> data = await mysql.read("tasks");

    if(data.isEmpty){
      return null;
    }
     List<Task> tasks=data.map((e) {
      return Task(
        id: e["id"],
        title: e["title"],
        note: e["note"],
        color: e["color"],
        isCompleted: e["iscompleted"],
        startTime: e["starttime"],
        endTime: e["endtime"],
        date: e["date"],
        remind: e["remind"],
        repeat: e["repeat"],
      );
    }).toList();
    tasks=tasks.where((element) =>(element.date==date||element.repeat =="Daily"||
        (element.repeat == 'Weekly' &&DateFormat.yMd().parse(date).difference(DateFormat.yMd().parse(element.date!)).inDays %7 ==0)
        ||
        (element.repeat == 'Monthly' &&DateFormat.yMd().parse(date).day == DateFormat.yMd().parse(element.date!).day)
    )).toList();
    state=tasks;
  //   (element.repeat == 'Weekly' &&_selectedDate.difference(DateFormat.yMd().parse(task.date!)).inDays %7 ==0)
    // ||
    //   (element.repeat == 'Monthly' &&DateFormat.yMd().parse(task.date!).day == _selectedDate.day)
  }
  
 Future <void> add_task(
     {
       required String title,
       required String note,
       required String starttime,
       required String endtime,
       required date,
       required String repeat,
       required int iscompleted,
       required int remind,
       required int color,
       required DateTime time,
       required TimeOfDay start,
       required TimeOfDay end
     }) async{
    String repeatmessege="off";
    final Task instanced = Task(
      title: title,
      note: note,
      startTime: starttime,
      endTime: endtime,
      color: color,
      isCompleted:iscompleted,
      remind:remind,
      date:date,
      repeat:repeat);
    sql mysql=sql();
    int mass= await mysql.insert("tasks", {
      "title": title,
      "note": note,
      "starttime": starttime,
      "endtime": endtime,
      "color": color,
      "iscompleted":iscompleted,
      "remind":remind,
      "date":date,
      "repeat": repeat});

  String dialog=await  LocalNotifictionServiece.showschadule_mody_Notification(
        start: starttime,
        iscompleted:iscompleted ,
        end:endtime ,
        repeat: repeat,
        color:color ,
        reminder: remind,
        date:date ,
        note:note ,
        title:title ,
        minute:start.minute,
        day:time.day ,
        hour:start.hour ,
        month:time.month ,
        year:time.year,
        id: mass
    );
    if(repeat!='None'&&repeat!='Monthly'){
      LocalNotifictionServiece.repeatnotify(
        id: -mass,
        color:color ,
        title: title,
        note: note,
        repeat:repeat,
        date: date,
        end:endtime ,
        iscompleted:iscompleted ,
        remind:remind ,
        start:starttime ,
      );
      repeatmessege="on";
    }
    Get.showSnackbar( GetSnackBar(
         message: "Your schedule $dialog, repeat notifier from now is $repeatmessege",
    duration: Duration(seconds: 4),));
    state = [instanced, ...state];
  }
  
  void delete_tasks()async{
    sql mysql=sql();
    await mysql.deletedb(
        "DELETE FROM tasks WHERE id = id");
    state=[];
  }

  Future <void>deleteSingletask(int? id)async{
    sql mysql = sql();
    await mysql.deletedb("DELETE FROM tasks WHERE id = $id");
    state=state.where((element) => element.id != id).toList();
  }

  Future <void>updatetask(Task task,int id)async{
    task.isCompleted=1;
    sql mysql=sql();
    await mysql.update(
        "tasks",
        {
          "iscompleted":1,
        },
        "id=$id");
  }
}

final Tasks_list_Provider = StateNotifierProvider<Place_provider, List<Task>>(
        (ref) => Place_provider());
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notify/notify.dart';

class Musical extends StatefulWidget {
  Musical({super.key});

  @override
  State<Musical> createState() => _MusicalState();
}

class _MusicalState extends State<Musical> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay start = TimeOfDay.now();
  TimeOfDay end = TimeOfDay.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
          ElevatedButton(
              onPressed: () {
                LocalNotifictionServiece.flutterLocalNotificationsPlugin
                    .cancelAll();
              },
              child: Icon(Icons.cancel_presentation)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(_startTime),
              IconButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  var timeend = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (timeend != null) {
                    setState(() {
                    start = timeend;
                      _startTime = timeend.format(context);
                    });
                  }
                },
                icon: const Icon(
                  Icons.access_time_rounded,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat.yMd().format(_selectedDate)),
              IconButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  var timed = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 2)),
                      lastDate: DateTime.now().add(Duration(days: 366)));
                  if (timed != null) {
                    setState(() {
                      _selectedDate = timed;
                    });
                  }
                },
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {

              },
              child: Text("the modyscahd")),
        ],

      ),
    );
  }
}
//LocalNotifictionServiece.Scheduletimer(mass,DateTime.now(), single,title,note,date);
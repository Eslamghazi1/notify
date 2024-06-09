import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, this.payload}) : super(key: key);
  String? payload;
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payload = widget.payload!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _payload.toString().split("|")[0].toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        // Colors.blueGrey,
        // context.theme.primaryColor,
        // Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Hello",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Get.isDarkMode ? Colors.white : darkGreyClr),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "You hava a new reminder",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                  color: Get.isDarkMode ? Colors.white : darkGreyClr),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blueGrey,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title text
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.text_format_rounded,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Title",
                          style: Themes().haedingstyle.copyWith(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),

                    // the title title
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _payload.toString().split("|")[0],
                      textAlign: TextAlign.justify,
                      style: Themes().substyle.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // the date text
                        Text("Date",
                            style: Themes().haedingstyle.copyWith(
                                  fontSize: 28,
                                  color: Colors.white,
                                )),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // the date title
                    Text(
                      _payload.toString().split("|")[1],
                      textAlign: TextAlign.justify,
                      style: Themes().substyle.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.access_time_filled,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),

                        // the note text
                        Text(
                          "Start time",
                          style: Themes()
                              .haedingstyle
                              .copyWith(fontSize: 28, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text(
                      textAlign: TextAlign.center,
                      _payload.toString().split("|")[3],
                      style:
                      Themes().substyle.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 20,),
                    // the note text
                    Row(
                      children: [
                    Icon(
                      Icons.access_time_filled,
                      size: 35,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                        Text(
                          "End time",
                          style: Themes()
                              .haedingstyle
                              .copyWith(fontSize: 28, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // the note title
                    Text(
                      textAlign: TextAlign.center,
                      _payload.toString().split("|")[4],
                      style:
                          Themes().substyle.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.repeat_on,
                          size: 35,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Repeated",
                          style: Themes().haedingstyle.copyWith(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      _payload.toString().split("|")[5],
                      style: Themes().substyle.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.remember_me_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Reminder",
                          style: Themes().haedingstyle.copyWith(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      textAlign: TextAlign.center,
                      "Before time ${_payload.toString().split("|")[6]} minutes",
                      style: Themes().substyle.copyWith(color: Colors.white),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.incomplete_circle,
                          size: 35,
                          color:Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Note Type",
                          style: Themes().haedingstyle.copyWith(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      _payload.toString().split("|")[7] == "1"
                          ? "Completed"
                          : "To do",
                      style: Themes().substyle.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.color_lens,
                          size: 35,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Color",
                          style: Themes().haedingstyle.copyWith(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          backgroundColor: _payload.toString().split("|")[8] == "1"
                              ? pinkClr
                              : _payload.toString().split("|")[8] == "2"
                                  ? orangeClr
                                  : primaryClr,
                          radius: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // const SizedBox(
                    //   height: 10,
                    // ),

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.description,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 20,
                        ),

                        // the note text
                        Text(
                          "Description",
                          style: Themes()
                              .haedingstyle
                              .copyWith(fontSize: 28, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // the note title
                    Text(
                      _payload.toString().split("|")[2],
                      style: Themes().substyle.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

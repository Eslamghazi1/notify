import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'size_config.dart';
import 'task.dart';
import 'theme.dart';

class TaskTile extends ConsumerStatefulWidget {
  const TaskTile(this.task,{Key? key}) : super(key: key);
  final Task task;

  @override
  ConsumerState<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends ConsumerState<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
            SizeConfig.orientation == Orientation.landscape ? 4 : 4),
      ),
      height: SizeConfig.screenHeight / 5,
      width:
      SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(widget.task.color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: SizeConfig.screenHeight / 4,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.task.title!,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                            widget.task.date!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white)
                        ),
                        SizedBox(width: 10,),
                        Text(
                            "<> Repeated ${widget.task.repeat!}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white)
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${widget.task.startTime} - ${widget.task.endTime}',
                          style:  TextStyle(
                            fontSize: 13,
                            color: Colors.grey[100],
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text(textAlign: TextAlign.right,
                          ' <> ${widget.task.remind} M earlier reminder',
                          style:  TextStyle(
                            fontSize: 13,
                            color: Colors.grey[100],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.task.note!,
                      style:TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100],
                      ),

                    ),
                  ],
                ),
              ),
            ),
                   Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    width: 0.5,
                    color: Colors.grey[200]!.withOpacity(0.7),
                  ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                widget.task.isCompleted == 0 ? 'TODO' : 'Completed',
                style:  const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}


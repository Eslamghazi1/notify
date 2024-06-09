import 'package:flutter/material.dart';

import 'size_config.dart';

class MyButton extends StatelessWidget {
   MyButton({Key? key,
     required this.label,
     required this.onTap,
   }) : super(key: key);
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ElevatedButton(
      onPressed: onTap,
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        width:50,
        height: 50,
        child: Center(
          child: Text(label,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({
    Key? key,
    this.hintText,
    this.func,
    this.sendMessageFunc,
  }) : super(key: key);

  final String? hintText;
  final Function(String)? func;
  final Function()? sendMessageFunc;

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            style: BorderStyle.solid,
            color: const Color.fromARGB(255, 132, 132, 132),
            width: 2,
          ),
        ),
        margin: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 15.w, left: 15.w),
        padding: EdgeInsets.all(15.w),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration:
                    InputDecoration.collapsed(hintText: widget.hintText),
                onChanged: widget.func,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

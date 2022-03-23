import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Message extends StatelessWidget {
  const Message({Key? key, this.func, this.sendMessageFunc, this.hintText})
      : super(key: key);

  final Function(String)? func;
  final Function()? sendMessageFunc;
  final String? hintText;

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
        padding: EdgeInsets.all(5.w),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: hintText),
                onChanged: func,
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
              onPressed: sendMessageFunc,
            ),
          ],
        ),
      ),
    );
  }
}

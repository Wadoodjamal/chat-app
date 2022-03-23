import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    this.message,
    this.isMe,
    this.myName,
    this.personName,
  }) : super(key: key);

  final String? message;
  final String? myName;
  final String? personName;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Row(
        mainAxisAlignment:
            isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(8.w),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color:
                  isMe! ? Theme.of(context).primaryColor : Colors.grey.shade300,
              borderRadius: BorderRadius.all(
                Radius.circular(12.r),
              ),
            ),
            constraints: BoxConstraints(
              maxWidth: 200.w,
            ),
            child: Column(
              crossAxisAlignment:
                  isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isMe! ? myName! : personName!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: isMe! ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  message!,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: isMe! ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

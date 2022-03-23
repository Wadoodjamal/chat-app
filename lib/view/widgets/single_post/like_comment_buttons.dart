import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeCommentButtons extends StatelessWidget {
  const LikeCommentButtons({
    Key? key,
    this.text,
    this.isComment,
    this.func,
    this.liked = false,
  }) : super(key: key);

  final bool liked;
  final String? text;
  final bool? isComment;
  final Function()? func;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => TextButton(
        onPressed: liked ? null : func,
        style: TextButton.styleFrom(
          backgroundColor:
              liked ? Colors.white : Theme.of(context).primaryColor,
        ),
        child: Text(
          text!,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: liked ? Theme.of(context).primaryColor : Colors.white),
        ),
      ),
    );
  }
}

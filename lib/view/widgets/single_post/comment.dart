import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Comment extends StatelessWidget {
  const Comment({Key? key, this.name, this.comment}) : super(key: key);

  final String? name;
  final String? comment;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 8.h, right: 15.w, left: 15.w),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            style: BorderStyle.solid,
            color: const Color.fromARGB(255, 132, 132, 132),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name ?? '',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            Text(
              comment ?? '',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

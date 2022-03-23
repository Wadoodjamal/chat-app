import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SinglePostCustomContainer extends StatelessWidget {
  const SinglePostCustomContainer({
    Key? key,
    this.postTitle,
    this.postDescription,
    this.currentIndex,
    this.navigateToSinglePost,
    this.alpha,
    this.red,
    this.green,
    this.blue,
  }) : super(key: key);

  final String? postTitle;
  final String? postDescription;
  final int? currentIndex;
  final int? alpha;
  final int? red;
  final int? green;
  final int? blue;
  final Function(int)? navigateToSinglePost;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              spreadRadius: 5.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 13.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                postTitle ?? '',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(alpha!, red!, green!, blue!)),
              ),
              SizedBox(height: 12.h),
              Text(
                postDescription ?? '',
                maxLines: 3,
                style: TextStyle(
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                    color: Color.fromARGB(alpha!, red!, green!, blue!)),
              ),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.only(left: 146.w),
                child: GestureDetector(
                  onTap: () => navigateToSinglePost!(currentIndex!),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Read More',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(width: 14.w),
                      CircleAvatar(
                        radius: 12.5.r,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 17.h,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

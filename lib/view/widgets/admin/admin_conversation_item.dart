import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminConversationItem extends StatelessWidget {
  const AdminConversationItem({
    Key? key,
    this.conversationName,
    this.lastMessageTime,
    this.lastMessage,
    this.func,
    this.id,
  }) : super(key: key);

  final String? conversationName;
  final String? lastMessageTime;
  final String? lastMessage;
  final String? id;
  final Function(String)? func;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: ListTile(
        leading: CircleAvatar(
          radius: 22.r,
          foregroundImage: const AssetImage('assets/images/person.png'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  conversationName ?? '',
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Text(
                  lastMessage ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(width: 10.w),
                Text(
                  lastMessageTime ?? '',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(context).primaryColor.withOpacity(0.5)),
                ),
              ],
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            func!(id!);
          },
          child: Text(
            'Delete',
            style: TextStyle(
                fontSize: 16.sp, color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}

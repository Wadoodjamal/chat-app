import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminPostItem extends StatelessWidget {
  const AdminPostItem({
    this.id,
    Key? key,
    this.title,
    this.time,
    this.onApproved,
    this.onDelete,
  }) : super(key: key);

  final String? title;
  final String? time;
  final int? id;
  final Function(int)? onApproved;
  final Function(int)? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22.r,
        child: Text(
          '${id! + 1}',
          style: TextStyle(fontSize: 18.sp),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                '$time .',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                'Details',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14.sp, color: Theme.of(context).primaryColor),
              ),
            ],
          )
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () => onApproved!(id!),
              child: _approvedAndDeleteText(context, text: 'Approved')),
          SizedBox(height: 10.h),
          GestureDetector(
              onTap: () => onDelete!(id!),
              child: _approvedAndDeleteText(context, text: 'Delete')),
        ],
      ),
    );
  }

  Text _approvedAndDeleteText(BuildContext context, {String? text}) {
    return Text(
      text ?? '',
      style: TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor),
    );
  }
}

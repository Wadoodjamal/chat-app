import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminUserItem extends StatelessWidget {
  const AdminUserItem({
    Key? key,
    this.name,
    this.onDelete,
    this.currentIndex,
  }) : super(key: key);

  final int? currentIndex;
  final Function(int)? onDelete;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22.r,
        foregroundImage: const AssetImage('assets/images/person.png'),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name ?? '',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
        ],
      ),
      trailing: GestureDetector(
        onTap: () => onDelete!(currentIndex!),
        child: Text(
          'Delete',
          style:
              TextStyle(fontSize: 16.sp, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

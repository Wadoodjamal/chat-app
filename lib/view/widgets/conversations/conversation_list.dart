import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/chat.dart';

class ConversationListView extends StatefulWidget {
  const ConversationListView({
    Key? key,
    this.names,
    this.imagePath,
    this.messages,
    this.time,
    this.chatID,
    this.personID,
    this.myName,
  }) : super(key: key);

  final List? names;
  final List? imagePath;
  final List? messages;
  final List? time;
  final List? chatID;
  final List? personID;
  final String? myName;

  @override
  State<ConversationListView> createState() => _ConversationListViewState();
}

class _ConversationListViewState extends State<ConversationListView> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => ListView.builder(
        itemCount: widget.names!.length,
        shrinkWrap: true,
        itemBuilder: ((context, index) => Dismissible(
              key: Key(index.toString()),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                return await _showDialog(context);
              },
              background: Container(
                color: const Color.fromARGB(255, 255, 231, 229),
                child: Image.asset(
                  'assets/icons/Shape.png',
                  color: Colors.red,
                ),
              ),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      personName: widget.names![index],
                      chatID: widget.chatID![index],
                      myName: widget.myName,
                      personID: widget.personID![index],
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 18.h),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 231, 231, 231),
                      ),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: ListTile(
                    leading: Image.asset(
                      widget.imagePath![index],
                      width: 40.w,
                      height: 40.h,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.names![index],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        if (!widget.messages![index].isEmpty)
                          Text(
                            widget.messages![index],
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14.sp,
                              color: const Color.fromARGB(255, 60, 60, 60),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                      ],
                    ),
                    trailing: Text(
                      widget.time![index],
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.sp,
                        color: const Color.fromARGB(255, 60, 60, 60),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Future<bool?> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Image.asset(
              'assets/icons/delete.png',
              width: 67.w,
              height: 67.h,
            ),
            SizedBox(height: 17.h),
            Text(
              'Delete Message',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
        content: const Text('Do you really want to delete this conversation?'),
        contentTextStyle: TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w100,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: _showDialogButtons(context, text: 'Cancel'),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child:
                    _showDialogButtons(context, text: 'Delete', isDelete: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextButton _showDialogButtons(BuildContext context,
      {String? text, bool isDelete = false}) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor:
            isDelete ? Theme.of(context).primaryColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            color: isDelete ? Colors.white : Theme.of(context).primaryColor,
            width: 1.w,
          ),
        ),
      ),
      child: Text(
        text!,
        style: TextStyle(
            color: isDelete ? Colors.white : Theme.of(context).primaryColor),
      ),
      onPressed: () => Navigator.of(context).pop(false),
    );
  }
}

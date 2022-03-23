import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/user/message.dart';

class GuestLogin extends StatefulWidget {
  const GuestLogin({Key? key}) : super(key: key);

  @override
  State<GuestLogin> createState() => _GuestLoginState();
}

class _GuestLoginState extends State<GuestLogin> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      alertDialog();
    });
    _fetchPostsData();
  }

  List<QueryDocumentSnapshot> _posts = [];

  void _fetchPostsData() async {
    await FirebaseFirestore.instance
        .collection('allPosts')
        .where('approved', isEqualTo: true)
        .get()
        .then((value) => {
              setState(() {
                _posts = value.docs;
              })
            });
  }

  void _moveToNextPage(value) {
    var check = false;
    if (_posts[value].get('comments').isNotEmpty) {
      check = true;
    }
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SinglePost(
          currentPage: 'GUEST',
          title: _posts[value].get('title'),
          description: _posts[value].get('content'),
          id: _posts[value].id,
        ),
      ),
    );
  }

  void alertDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Image.asset('assets/icons/signup.png', width: 80.w, height: 80.h),
              SizedBox(height: 16.h),
              Text('Signup Now',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
            ],
          ),
          content: const Text(
              'You can only view 5 post as a guests signup now to view all',
              textAlign: TextAlign.center),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: _showDialogButtons(context, text: 'Cancel'),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _showDialogButtons(context,
                      text: 'Signup', isDelete: true),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: const Icon(Icons.menu),
          title: Text(
            'All Posts',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
            ),
          ),
          actions: <Widget>[
            Image.asset(
              'assets/icons/man.png',
              width: 50.w,
              height: 50.h,
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 30.h),
          child: ListView.builder(
            itemBuilder: ((context, index) => SinglePostCustomContainer(
                  postTitle: _posts[index].get('title'),
                  postDescription: _posts[index].get('content'),
                  currentIndex: index,
                  navigateToSinglePost: _moveToNextPage,
                )),
            shrinkWrap: true,
            itemCount: _posts.length < 5 ? _posts.length : 5,
          ),
        ),
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

class SinglePostCustomContainer extends StatelessWidget {
  const SinglePostCustomContainer({
    Key? key,
    this.postTitle,
    this.postDescription,
    this.currentIndex,
    this.navigateToSinglePost,
  }) : super(key: key);

  final String? postTitle;
  final String? postDescription;
  final int? currentIndex;
  final Function(int)? navigateToSinglePost;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 12.h),
            Text(
              postDescription ?? '',
              maxLines: 3,
              style:
                  TextStyle(fontSize: 14.sp, overflow: TextOverflow.ellipsis),
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
    );
  }
}

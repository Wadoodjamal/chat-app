import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/admin/dashboard.dart';
import 'package:turu/view/screens/user/all_posts.dart';
import 'package:turu/view/screens/user/create_a_new_post.dart';

class BottomButtons extends StatefulWidget {
  const BottomButtons({
    Key? key,
    this.text,
    this.navigateTo,
    this.email,
    this.password,
    this.postTitle,
    this.postContent,
    this.postTags,
    this.color,
  }) : super(key: key);

  final String? text;
  final String? navigateTo;
  final String? email;
  final String? password;
  final String? postTitle;
  final String? postContent;
  final String? postTags;
  final Color? color;

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  void navigateToNextPage() {
    if (widget.navigateTo == 'login') {
      if (_checkSignInValidity()) {
        _signInUser();
      }
    } else if (widget.navigateTo == 'signup') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else if (widget.navigateTo == 'submit') {
      if (_checkSubmitPostValidity()) {
        _submitPost();
      }
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const AllPosts()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Padding(
        padding: EdgeInsets.only(left: 159.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text!,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: navigateToNextPage,
              child: CircleAvatar(
                radius: 22.5.r,
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _checkSignInValidity() {
    if (widget.email == null || widget.password == null) {
      _showDialog('Email or password cannot be empty');
      return false;
    } else {
      return true;
    }
  }

  bool _checkSubmitPostValidity() {
    if (widget.postTitle == null ||
        widget.postContent == null ||
        widget.postTags == null) {
      _showDialog('Post title, content and tags cannot be empty');
      return false;
    } else {
      return true;
    }
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Input!'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _submitPost() async {
    try {
      final User user = FirebaseAuth.instance.currentUser!;
      final currentHour = DateTime.now().hour;
      final currentMinutes = DateTime.now().minute;
      final amOrPm = currentHour < 12 ? 'AM' : 'PM';

      await FirebaseFirestore.instance.collection('allPosts').add({
        'title': widget.postTitle!,
        'content': widget.postContent!,
        'tags': widget.postTags!,
        'author': user.email,
        'userID': user.uid,
        'textColor': [
          widget.color!.alpha,
          widget.color!.red,
          widget.color!.green,
          widget.color!.blue,
        ],
        'approved': false,
        'time': '$currentHour:$currentMinutes $amOrPm',
        'likedBy': [],
        'commentedBy': [],
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AllPosts()));
    } catch (error) {
      print(error);
    }
  }

  void _signInUser() async {
    try {
      if (widget.email!.split('@')[1] == 'admin.com') {
        await FirebaseFirestore.instance
            .collection('admin')
            .get()
            .then((value) => {
                  value.docs.forEach((element) {
                    if (element.data()['email'] == widget.email!.trim()) {
                      if (element.data()['password'] == widget.password) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminDashboard()),
                        );
                      }
                    } else {
                      _showDialog('User not found!');
                    }
                  })
                });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((value) => {
                  value.docs.forEach((element) {
                    if (element.data()['email'] == widget.email) {
                      if (element.data()['password'] == widget.password) {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: widget.email!, password: widget.password!);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllPosts()),
                        );
                      }
                    } else {
                      _showDialog('User not found!');
                    }
                  }),
                });
      }
    } catch (error) {
      print(error);
    }
  }
}

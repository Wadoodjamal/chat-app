import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/user/all_posts.dart';
import 'package:turu/view/screens/user/conversation.dart';
import 'package:turu/view/screens/user/guest_login.dart';
import 'package:turu/view/widgets/chat/new_message.dart';
import 'package:turu/view/widgets/single_post/comment_section.dart';
import 'package:turu/view/widgets/single_post/like_comment_buttons.dart';

class SinglePost extends StatefulWidget {
  const SinglePost({
    Key? key,
    this.title,
    this.description,
    this.id,
    this.currentPage,
    this.alpha,
    this.red,
    this.green,
    this.blue,
    this.authorID,
  }) : super(key: key);

  final String? authorID;
  final String? title;
  final String? description;
  final String? id;
  final String? currentPage;
  final int? alpha;
  final int? red;
  final int? green;
  final int? blue;

  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  bool isLiked = false;
  String comment = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: GestureDetector(
              onTap: () {
                widget.currentPage == 'GUEST'
                    ? Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GuestLogin()))
                    : Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllPosts(),
                        ),
                      );
              },
              child: const Icon(Icons.arrow_back_outlined)),
          title: Text(
            widget.title ?? '',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
              color: Color.fromARGB(
                  widget.alpha!, widget.red!, widget.green!, widget.blue!),
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
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 36.h,
                  ),
                  Text(
                    widget.title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: Color.fromARGB(widget.alpha!, widget.red!,
                          widget.green!, widget.blue!),
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(2, 2), // changes position of shadow
                        ),
                      ], // boxShadow
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Text(
                        widget.description ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color.fromARGB(widget.alpha!, widget.red!,
                              widget.green!, widget.blue!),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: LikeCommentButtons(
                          text: isLiked ? 'Liked' : 'Like',
                          isComment: false,
                          liked: isLiked,
                          func: _likePost,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: LikeCommentButtons(
                          text: 'Comment',
                          isComment: true,
                          func: _commentPost,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: 126.w, vertical: 10.h),
                    ),
                    onPressed: () {
                      _chatInInbox();
                      // );
                    },
                    child: Text(
                      'Chat in Inbox',
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  NewMessage(
                    hintText: 'Type a comment',
                    func: _setComment,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: CommentSection(postID: widget.id),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _commentPost() async {
    if (comment.isEmpty) {
      _showDialog('In order to comment on post, write a comment first.');
    } else {
      final User? user = FirebaseAuth.instance.currentUser;
      String? userName;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get()
          .then((value) => {
                userName = value.get('name'),
              });

      await FirebaseFirestore.instance.collection('comments').add({
        'postID': widget.id,
        'commentedBy': userName,
        'comment': comment,
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .update({
        'commentedPosts': FieldValue.arrayUnion([widget.id]),
      });

      await FirebaseFirestore.instance
          .collection('allPosts')
          .doc(widget.id)
          .update({
        'commentedBy': FieldValue.arrayUnion([user?.uid]),
      });
    }
  }

  void _showDialog(String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _fetchUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {
              setState(() {
                isLiked = value.get('likedPosts').contains(widget.id);
              }),
            });
  }

  void _likePost() async {
    setState(() {
      isLiked = true;
    });

    final User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('allPosts')
        .doc(widget.id)
        .update({
      'likedBy': FieldValue.arrayUnion([user?.uid]),
    });
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
      'likedPosts': FieldValue.arrayUnion([widget.id]),
    });
  }

  void _setComment(value) {
    setState(() {
      comment = value;
    });
  }

  void _chatInInbox() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (widget.authorID == user?.uid) {
      _showDialog('You cannot chat to yourself or do you?');
    } else {
      bool check = false;
      await FirebaseFirestore.instance
          .collection('conversation')
          .get()
          .then((value) => {
                if (value.docs.isEmpty)
                  check = false
                else
                  {
                    value.docs.forEach((element) {
                      if (element.get('member1') == user?.uid &&
                          element.get('member2') == widget.authorID) {
                        check = true;
                      } else if (element.get('member2') == user?.uid &&
                          element.get('member1') == widget.authorID) {
                        check = true;
                      }
                    })
                  }
              });
      if (check) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyConversation()),
        );
      } else {
        _addNewConversation();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyConversation()),
        );
      }
    }
  }

  void _addNewConversation() async {
    final User? user = FirebaseAuth.instance.currentUser;
    String? conversationID;
    String? member1Name;
    String? member2Name;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.authorID)
        .get()
        .then((value) => {
              member2Name = value.get('name'),
            });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) => {
              member1Name = value.get('name'),
            });

    await FirebaseFirestore.instance.collection('conversation').add({
      'member1': user.uid,
      'member2': widget.authorID,
      'member1Name': member1Name,
      'member2Name': member2Name,
      'lastMessageTime': '',
      'timeStamp': Timestamp.now(),
      'lastMessage': '',
    }).then((value) => {
          conversationID = value.id,
        });

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'inbox': FieldValue.arrayUnion([conversationID]),
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.authorID)
        .update({
      'inbox': FieldValue.arrayUnion([conversationID]),
    });
  }
}

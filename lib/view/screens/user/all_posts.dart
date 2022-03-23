import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/user/create_a_new_post.dart';
import 'package:turu/view/screens/user/message.dart';
import 'package:turu/view/screens/user/user_drawer.dart';
import 'package:turu/view/widgets/single_post/single_post_container.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({Key? key}) : super(key: key);

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  @override
  void initState() {
    super.initState();
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
    _posts[value].id;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SinglePost(
          authorID: _posts[value].get('userID'),
          currentPage: 'POSTS',
          title: _posts[value].get('title'),
          description: _posts[value].get('content'),
          id: _posts[value].id,
          alpha: _posts[value].get('textColor')[0],
          red: _posts[value].get('textColor')[1],
          green: _posts[value].get('textColor')[2],
          blue: _posts[value].get('textColor')[3],
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        key: _scaffoldKey,
        drawer: const UserDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
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
        body: _posts.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(top: 30.h),
                child: SizedBox(
                  child: ListView.builder(
                    itemBuilder: ((context, index) => SinglePostCustomContainer(
                          postTitle: _posts[index].get('title'),
                          postDescription: _posts[index].get('content'),
                          currentIndex: index,
                          alpha: _posts[index].get('textColor')[0],
                          red: _posts[index].get('textColor')[1],
                          green: _posts[index].get('textColor')[2],
                          blue: _posts[index].get('textColor')[3],
                          navigateToSinglePost: _moveToNextPage,
                        )),
                    shrinkWrap: true,
                    itemCount: _posts.length,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
      ),
    );
  }
}

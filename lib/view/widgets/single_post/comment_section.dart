import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:turu/view/widgets/single_post/comment.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({Key? key, this.postID}) : super(key: key);

  final String? postID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('comments').snapshots(),
      builder: (context, snapshot) {
        List<String> comments = [];
        List<String> userName = [];

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          snapshot.data!.docs.forEach((element) async {
            if (element.get('postID') == postID) {
              comments.add(element.get('comment'));
              userName.add(element.get('commentedBy'));
            }
          });
          if (comments.isEmpty || userName.isEmpty) {
            return const Center(
              child: Text('No comments yet',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            );
          } else {
            return ListView.builder(
              itemCount: comments.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Comment(
                  name: userName[index],
                  comment: comments[index],
                );
              },
            );
          }
        }
      },
    );
  }
}

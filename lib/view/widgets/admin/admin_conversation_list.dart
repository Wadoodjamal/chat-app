import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:turu/view/widgets/admin/admin_conversation_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminConversationsList extends StatefulWidget {
  const AdminConversationsList({Key? key}) : super(key: key);

  @override
  _AdminConversationsListState createState() => _AdminConversationsListState();
}

class _AdminConversationsListState extends State<AdminConversationsList> {
  void _deleteConversation(id) async {
    await FirebaseFirestore.instance
        .collection('conversation')
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('conversation')
              .orderBy('timeStamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            List _conversations = [];
            List _lastMessage = [];
            List _lastMessageTime = [];
            List _chatID = [];
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              snapshot.data!.docs.forEach((element) {
                _conversations.add(
                    '${element.get('member1Name')} , ${element.get('member2Name')}');
                _lastMessage.add(element.get('lastMessage'));
                _lastMessageTime.add(element.get('lastMessageTime'));
                _chatID.add(element.id);
              });
              return ListView.builder(
                itemCount: _conversations.length,
                shrinkWrap: true,
                itemBuilder: ((context, index) => AdminConversationItem(
                      conversationName: _conversations[index],
                      lastMessage: _lastMessage[index],
                      lastMessageTime: _lastMessageTime[index],
                      id: _chatID[index],
                      func: _deleteConversation,
                    )),
              );
            }
          }),
    );
  }
}

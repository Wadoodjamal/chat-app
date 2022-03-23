import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/widgets/chat/message.dart';
import 'package:turu/view/widgets/chat/message_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    this.personName,
    this.chatID,
    this.myName,
    this.personID,
  }) : super(key: key);

  final String? personName;
  final String? chatID;
  final String? myName;
  final String? personID;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message = '';

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              widget.personName!,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24.sp),
            ),
            centerTitle: true,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .orderBy('timeStamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<QueryDocumentSnapshot> _documentSnapshots = [];
                      List _isMe = [];
                      List _messages = [];
                      print('Chat ID is: ${widget.chatID}');
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        snapshot.data!.docs.forEach((element) {
                          if (element.get('chatID') == widget.chatID) {
                            _documentSnapshots.add(element);
                          }
                        });

                        _documentSnapshots.forEach((element) {
                          if (element.get('sentBy') == widget.myName) {
                            _isMe.add(true);
                            _messages.add(element.get('message'));
                          } else {
                            _isMe.add(false);
                            _messages.add(element.get('message'));
                          }
                        });

                        return Messages(
                          isMeList: _isMe,
                          messagesList: _messages,
                          myName: widget.myName,
                          personName: widget.personName,
                        );
                      }
                    }),
              ),
              Message(
                hintText: 'Type a message',
                func: _setMessage,
                sendMessageFunc: _sendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter a message to send.'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _sendMessage() async {
    if (message.isEmpty) {
      _showDialog();
    } else {
      final String userID = FirebaseAuth.instance.currentUser!.uid;
      final String chatID = widget.chatID!;
      final Timestamp timeStamp = Timestamp.now();
      final String personID = widget.personID!;
      final String personName = widget.personName!;

      await FirebaseFirestore.instance.collection('messages').add({
        'chatID': chatID,
        'message': message,
        'timeStamp': timeStamp,
        'sentBy': widget.myName,
        'sentTo': personName,
        'senderID': userID,
        'receiverID': personID,
      });

      String amOrPm = timeStamp.toDate().hour >= 12 ? 'PM' : 'AM';

      await FirebaseFirestore.instance
          .collection('conversation')
          .doc(chatID)
          .update({
        'lastMessage': message,
        'timeStamp': timeStamp,
        'lastMessageTime': timeStamp.toDate().hour.toString() +
            ':' +
            timeStamp.toDate().minute.toString() +
            ' ' +
            amOrPm,
      });

      setState(() {
        message = '';
      });
    }
  }

  void _setMessage(value) {
    setState(() {
      message = value;
    });
  }
}

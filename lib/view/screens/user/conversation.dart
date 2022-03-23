import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/widgets/conversations/conversation_list.dart';

class MyConversation extends StatefulWidget {
  const MyConversation({Key? key}) : super(key: key);

  @override
  State<MyConversation> createState() => _MyConversationState();
}

class _MyConversationState extends State<MyConversation> {
  List imagesPath = [
    'assets/images/person.png',
    'assets/images/person.png',
    'assets/images/person.png'
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  List<dynamic> _inbox = [];
  String? name;

  void _fetchUserData() async {
    final String userID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((value) => {
              setState(() {
                _inbox = value.get('inbox');
                name = value.get('name');
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor, // appBar Color
          title: Text(
            'Conversation',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24.sp,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 23.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('conversation')
                    .orderBy('timeStamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  List<QueryDocumentSnapshot> documentSnapshots = [];
                  List secondPerson = [];
                  List lastMessage = [];
                  List lastMessageTime = [];
                  List secondPersonID = [];
                  List chatID = [];

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    print(_inbox);
                    if (_inbox.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      snapshot.data!.docs.forEach((element) {
                        if (_inbox.contains(element.id)) {
                          documentSnapshots.add(element);
                          chatID.add(element.id.trim());
                        }
                      });
                      // print('My inbox: ${_inbox}');
                      // print('Document Snapshots: $documentSnapshots');
                      documentSnapshots.forEach((element) {
                        if (element.get('member1Name') == name) {
                          secondPersonID.add(element.get('member2'));
                          secondPerson.add(element.get('member2Name'));
                          lastMessage.add(element.get('lastMessage'));
                          lastMessageTime.add(element.get('lastMessageTime'));
                        }
                        if (element.get('member2Name') == name) {
                          secondPersonID.add(element.get('member1'));
                          secondPerson.add(element.get('member1Name'));
                          lastMessage.add(element.get('lastMessage'));
                          lastMessageTime.add(element.get('lastMessageTime'));
                        }
                      });
                      print('Second Person: $secondPerson');
                      if (secondPerson.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ConversationListView(
                          names: secondPerson,
                          imagePath: imagesPath,
                          messages: lastMessage,
                          time: lastMessageTime,
                          chatID: chatID,
                          personID: secondPersonID,
                          myName: name,
                        );
                      }
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

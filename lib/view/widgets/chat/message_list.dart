import 'package:flutter/material.dart';
import 'package:turu/view/widgets/chat/chat_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({
    Key? key,
    this.isMeList,
    this.messagesList,
    this.myName,
    this.personName,
  }) : super(key: key);

  final List? isMeList;
  final List? messagesList;
  final String? myName;
  final String? personName;

  @override
  Widget build(BuildContext context) {
    messagesList!.reversed;
    return ListView.builder(
      reverse: true,
      itemCount: messagesList?.length ?? 0,
      itemBuilder: ((context, index) => ChatBubble(
            isMe: isMeList![index],
            message: messagesList![index],
            myName: myName,
            personName: personName,
          )),
    );
  }
}

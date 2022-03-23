import 'package:flutter/material.dart';

class InboxChat extends StatelessWidget{
  const InboxChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // back button
        backgroundColor: Colors.blueAccent,
        title: const Text('Busany Brazil', style: TextStyle(
          backgroundColor: Colors.blueAccent,
          fontWeight: FontWeight.bold,
          fontSize: 25,),
        ),
        actions: <Widget> [
          IconButton(onPressed: () {},
            icon: const Icon(Icons.account_circle),
          ),
          Padding(padding: const EdgeInsets.only(left: 5.0),
            child: IconButton(onPressed: (){},
              icon: const Icon(Icons.view_headline_outlined),
            ), )
        ],

      ),

      // Body
      body: Text(''),
    );
  }
}
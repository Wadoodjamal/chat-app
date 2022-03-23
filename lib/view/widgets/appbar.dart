import 'package:flutter/material.dart';

class AppBar extends StatelessWidget implements PreferredSizeWidget{
  const AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBar(

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
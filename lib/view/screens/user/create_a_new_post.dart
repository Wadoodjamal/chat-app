import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/widgets/bottom_buttons.dart';
import 'package:turu/view/widgets/custom_textformfields.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart' as colorpicker;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _postContent = '';
  String _postTitle = '';
  String _postTags = '';
  Color _color = Colors.black;

  void _setPostTitle(value) {
    setState(() {
      _postTitle = value;
    });
  }

  void _setPostContent(value) {
    setState(() {
      _postContent = value;
    });
  }

  void _setPostTags(value) {
    setState(() {
      _postTags = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu), // back button
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Add Post',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 55.h, left: 30.w, right: 30.w),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Select Color',
                      style: TextStyle(
                          fontSize: 23.sp, fontWeight: FontWeight.normal),
                    ),
                    GestureDetector(
                        onTap: () => _showColorDialog(),
                        child: Image.asset('assets/icons/color_wheel.png')),
                  ],
                ),
                SizedBox(height: 49.h),
                CustomTextFieldForms(
                  text: 'Title',
                  isObscure: false,
                  onChangedValue: _setPostTitle,
                ),
                SizedBox(
                  height: 33.h,
                ),
                Container(
                  color: Colors.white,
                  height: 146.h,
                  width: 308.w,
                  child: TextField(
                    expands: true,
                    onChanged: _setPostContent,
                    maxLines: null,
                    minLines: null,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      hintText: 'Add Post',
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 196.w),
                  child: Text(
                    'Upto 250 words',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 33.h,
                ),
                CustomTextFieldForms(
                  text: 'Tags',
                  isObscure: false,
                  onChangedValue: _setPostTags,
                ),
                SizedBox(
                  height: 33.h,
                ),
                BottomButtons(
                  text: 'Submit',
                  navigateTo: 'submit',
                  postContent: _postContent,
                  postTitle: _postTitle,
                  postTags: _postTags,
                  color: _color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showColorDialog() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  colorpicker.BlockPicker(
                    pickerColor: _color,
                    onColorChanged: (color) => setState(() => _color = color),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.w, vertical: 14.h),
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/user/all_posts.dart';
import 'package:turu/view/widgets/custom_textformfields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name = '';
  String _email = '';
  String _location = '';
  String _password = '';
  String _gender = '';

  void _setGender(value) {
    setState(() {
      _gender = value;
    });
  }

  void _setName(value) {
    setState(() {
      _name = value;
    });
  }

  void _setEmail(value) {
    setState(() {
      _email = value;
    });
  }

  void _setPassword(value) {
    setState(() {
      _password = value;
    });
  }

  void _setLocation(value) {
    setState(() {
      _location = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  _createAccountPoster(),
                  SizedBox(height: 36.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Form(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CustomTextFieldForms(
                                  text: 'Name',
                                  isObscure: false,
                                  onChangedValue: _setName,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: CustomTextFieldForms(
                                  text: 'Gender',
                                  isObscure: false,
                                  onChangedValue: _setGender,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 22.h),
                          CustomTextFieldForms(
                            text: 'Email',
                            isObscure: false,
                            onChangedValue: _setEmail,
                          ),
                          SizedBox(height: 22.h),
                          CustomTextFieldForms(
                            text: 'Password',
                            isObscure: true,
                            onChangedValue: _setPassword,
                          ),
                          SizedBox(height: 22.h),
                          CustomTextFieldForms(
                            text: 'Location',
                            isObscure: false,
                            onChangedValue: _setLocation,
                          ),
                          SizedBox(height: 50.h),
                          _bottomButton(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack _createAccountPoster() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 300.h,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(180.w),
              bottomRight: Radius.circular(180.w),
            ),
            shape: BoxShape.rectangle,
          ),
        ),
        Positioned(
          left: 40,
          child: Row(
            children: [
              Text(
                'Create\nAccount',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 45.sp,
                    fontWeight: FontWeight.w500),
              ),
              Image.asset(
                'assets/images/creativity_pana_1.png',
                height: 183.h,
                width: 183.w,
              ),
            ],
          ),
        )
      ],
    );
  }

  Padding _bottomButton() {
    return Padding(
      padding: EdgeInsets.only(left: 159.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap: () {
              if (_checkValidity()) {
                _signUp();
              }
            },
            child: CircleAvatar(
              radius: 22.5.r,
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _checkValidity() {
    bool check = false;
    if (_name.isEmpty) {
      _showDialog('Name cannot be empty');
      check = false;
    } else if (_gender.isEmpty) {
      _showDialog('Gender cannot be empty');
      check = false;
    } else if (_email.isEmpty) {
      _showDialog('Email cannot be empty');
      check = false;
    } else if (_password.isEmpty) {
      _showDialog('Password cannot be empty');
      check = false;
    } else if (_location.isEmpty) {
      _showDialog('Location cannot be empty');
      check = false;
    } else if (_name.isNotEmpty &&
        _gender.isNotEmpty &&
        _email.isNotEmpty &&
        _password.isNotEmpty &&
        _location.isNotEmpty) {
      check = true;
    }
    return check;
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const AllPosts()));
              },
            ),
          ],
        );
      },
    );
  }

  void _signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);

      final User? user = FirebaseAuth.instance.currentUser!;

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': _name,
        'email': _email,
        'location': _location,
        'password': _password,
        'gender': _gender,
        'likedPosts': [],
        'activeChats': [],
      }).then((value) => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AllPosts()),
            ),
          });
    } catch (e) {
      print(e);
    }
  }
}

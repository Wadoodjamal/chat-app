import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/user/signup.dart';
import 'package:turu/view/widgets/bottom_buttons.dart';
import 'package:turu/view/widgets/custom_textformfields.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? password;

  void setEmail(value) {
    setState(() {
      email = value;
    });
  }

  void setPassword(value) {
    setState(() {
      password = value;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Positioned(
                            top: -40.h,
                            left: -54.w,
                            child: Image.asset(
                              'assets/images/sign_in_page_top_eclipse.png',
                              height: 177.h,
                              width: 177.h,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 34.h, right: 41.w, left: 81.w),
                            child: Center(
                              child: Image.asset(
                                'assets/images/creativity_pana_1.png',
                                height: 253.h,
                                width: 253.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 55.h),
                            CustomTextFieldForms(
                              text: 'Email',
                              isObscure: false,
                              onChangedValue: setEmail,
                            ),
                            SizedBox(height: 15.h),
                            CustomTextFieldForms(
                              text: 'Password',
                              isObscure: true,
                              onChangedValue: setPassword,
                            ),
                            SizedBox(height: 56.h),
                            BottomButtons(
                              text: 'Sign In',
                              navigateTo: 'login',
                              email: email,
                              password: password,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp())),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/images/bottom_eclipse.png'),
                          Positioned(
                            right: 25.w,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
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
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turu/view/screens/user/guest_login.dart';
import 'package:turu/view/screens/user/login.dart';
import 'package:turu/view/screens/user/signup.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => Scaffold(
          body: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset('assets/images/top_eclipse.png')),
                    Image.asset(
                      'assets/images/creativity_pana_1.png',
                      width: 183.w,
                      height: 183.h,
                    ),
                    SizedBox(height: 47.h),
                    const CustomTextButtons(
                      text: 'Continue as a Guest',
                      isSignInOrUp: false,
                      naivgateTo: 'guest',
                    ),
                    SizedBox(height: 24.h),
                    const CustomTextButtons(
                      text: 'Sign In',
                      isSignInOrUp: true,
                      naivgateTo: 'login',
                    ),
                    SizedBox(height: 24.h),
                    const CustomTextButtons(
                      text: 'Sign Up',
                      isSignInOrUp: true,
                      naivgateTo: 'signup',
                    ),
                  ], //
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/bottom_eclipse.png'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButtons extends StatefulWidget {
  const CustomTextButtons({
    Key? key,
    this.text,
    this.isSignInOrUp,
    this.naivgateTo,
  }) : super(key: key);

  final String? text;
  final bool? isSignInOrUp;
  final String? naivgateTo;

  @override
  State<CustomTextButtons> createState() => _CustomTextButtonsState();
}

class _CustomTextButtonsState extends State<CustomTextButtons> {
  void navigateToNextPage() {
    if (widget.naivgateTo == 'guest') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GuestLogin()),
      );
    } else if (widget.naivgateTo == 'login') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else if (widget.naivgateTo == 'signup') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                  horizontal: widget.isSignInOrUp! ? 132.w : 61.w,
                  vertical: 17.h),
            ),
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor)),
        onPressed: () {
          navigateToNextPage();
        },
        child: Text(
          widget.text!,
          style: TextStyle(fontSize: 24.sp, color: Colors.white),
        ),
      ),
    );
  }
}

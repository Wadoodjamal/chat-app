import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldForms extends StatelessWidget {
  const CustomTextFieldForms({
    Key? key,
    this.text,
    this.isObscure,
    this.onChangedValue,
    // this.errorText,
  }) : super(key: key);

  final String? text;
  final bool? isObscure;
  final Function(String)? onChangedValue;
  // final String? errorText;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => TextFormField(
        onChanged: onChangedValue,
        obscureText: isObscure!,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
          fillColor: Colors.white70,
          filled: true,
          labelText: text,
          labelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 23.sp,
              color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

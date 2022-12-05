import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.obscureText,
    this.hintText,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;
  final Widget? suffixIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      autocorrect: false,
      enableSuggestions: false,
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
        fontSize: 17.sp,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(
          top: 4.w,
          bottom: 4.w,
          left: 5.w,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 17.sp,
        ),
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}

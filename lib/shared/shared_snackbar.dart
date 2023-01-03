import 'package:restaurant/constants/app_globals.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

showSharedSnackbar({
  required String title,
  required String message,
}) {
  return scaffoldMessengerKey.currentState!.showSnackBar(
    SnackBar(
      width: 95.w,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          SizedBox(height: 0.75.h),
          Text(
            message,
          ),
        ],
      ),
    ),
  );
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showSharedDialog({
  required BuildContext context,
  required bool barrierDismissible,
  required Widget title,
  required Widget content,
  void Function()? actionFunction1,
  Widget? actionLabel1,
  void Function()? actionFunction2,
  Widget? actionLabel2,
  void Function()? actionFunction3,
  Widget? actionLabel3,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Platform.isAndroid
            ?
            // Dialog for android platform
            AlertDialog(
                title: title,
                content: content,
                actions: [
                  if (actionFunction1 != null && actionLabel1 != null) ...[
                    TextButton(
                      onPressed: actionFunction1,
                      child: actionLabel1,
                    ),
                  ],
                  if (actionFunction2 != null && actionLabel2 != null) ...[
                    TextButton(
                      onPressed: actionFunction2,
                      child: actionLabel2,
                    ),
                  ],
                  if (actionFunction3 != null && actionLabel3 != null) ...[
                    TextButton(
                      onPressed: actionFunction3,
                      child: actionLabel3,
                    ),
                  ],
                ],
              )
            :
            // Dialog for ios platform
            CupertinoAlertDialog(
                title: title,
                content: content,
                actions: [
                  if (actionFunction1 != null && actionLabel1 != null) ...[
                    CupertinoDialogAction(
                      onPressed: actionFunction1,
                      child: actionLabel1,
                    ),
                  ],
                  if (actionFunction2 != null && actionLabel2 != null) ...[
                    CupertinoDialogAction(
                      onPressed: actionFunction2,
                      child: actionLabel2,
                    ),
                  ],
                  if (actionFunction3 != null && actionLabel3 != null) ...[
                    CupertinoDialogAction(
                      onPressed: actionFunction3,
                      child: actionLabel3,
                    ),
                  ],
                ],
              ),
      );
    },
  );
}

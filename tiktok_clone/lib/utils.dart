import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// View Model error 발생 시 보여줄 SnackBar
void showFirebaseErrorSnack(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        (error as FirebaseException).message ?? "Something wen't wrong...",
      ),
      // showCloseIcon: true,
      action: SnackBarAction(label: "OK", onPressed: () {}),
    ),
  );
}

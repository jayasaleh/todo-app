import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/utils/app_styles.dart';

extension AsyncValueUi on AsyncValue {
  void showAlertDialogError(BuildContext context) {
    if (!isLoading && hasError) {
      final errorMessage = _errorMessage(error);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.error, color: Colors.red, size: 40),
          title: Text(errorMessage, style: AppStyles.normalTextStyle),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('close', style: AppStyles.normalTextStyle),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

String _errorMessage(Object? error) {
  if (error is FirebaseAuthException) {
    return error.message ?? error.toString();
  } else {
    return error.toString();
  }
}

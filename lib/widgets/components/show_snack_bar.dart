import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required String message,
  required SnackBarState state,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,style: const TextStyle(color: Colors.white),),
      backgroundColor: getSnackBarBackgroundColor(state),
      duration: const Duration(seconds: 3),
    ));

Color getSnackBarBackgroundColor(SnackBarState state){
  switch(state){
    case SnackBarState.success: return Colors.green;
    case SnackBarState.error: return Colors.red;
  }
}

enum SnackBarState { success, error }

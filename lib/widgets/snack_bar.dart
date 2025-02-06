import 'package:chat_app_using_firebase/core/route_utils/route_utils.dart';
import 'package:flutter/material.dart';

void showSnackBar(String message, {bool isError = false}) {
  ScaffoldMessenger.of(RouteUtils.context).hideCurrentSnackBar();
  ScaffoldMessenger.of(RouteUtils.context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.red : null,
  ));
}

import 'package:flutter/material.dart';

Widget failedReadWidget(String failureMessage) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(width: 50, height: 50, "assets/images/alert.png"),
      const SizedBox(
        height: 10,
      ),
      Text(failureMessage, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey),),
    ],
  );
}

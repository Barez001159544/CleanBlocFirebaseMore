import 'package:flutter/material.dart';

Widget failedReadWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(width: 50, height: 50, "assets/images/alert.png"),
      const SizedBox(
        height: 10,
      ),
      const Text("An Error Occurred"),
    ],
  );
}

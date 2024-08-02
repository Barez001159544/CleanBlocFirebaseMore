import 'package:flutter/material.dart';

Widget loadingReadWidget() {
  return const SizedBox(
    height: 100,
    width: 100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 1,
          width: 100,
          child: LinearProgressIndicator(
            minHeight: 1,
            backgroundColor: Colors.grey,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: 100,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Text(
              "Loading...",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    ),
  );
}

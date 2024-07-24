import 'package:flutter/material.dart';

import '../../core/theme_data.dart';

class DeleteAndUpdateButton extends StatefulWidget {
  const DeleteAndUpdateButton({
    super.key,
    required this.btnText,
    required this.btnTextColor,
    required this.onClick,
  });

  final String btnText;
  final Color btnTextColor;
  final VoidCallback onClick;
  @override
  State<DeleteAndUpdateButton> createState() => _DeleteAndUpdateButtonState();
}

class _DeleteAndUpdateButtonState extends State<DeleteAndUpdateButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap:()=> widget.onClick(),
        child: Container(
          height: kToolbarHeight,
          width: 100,
          color: themeData.scaffoldBackgroundColor,
          child: Center(child: Text(widget.btnText, style: TextStyle(fontSize: 18, color: widget.btnTextColor),)),
        ),
      ),
    );
  }
}

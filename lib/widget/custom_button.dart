import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;

  final Color color;
  final Widget child;
  const CustomButton({Key key, this.onPressed, this.color, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color, //    Color(0xff0020a9),
              borderRadius: BorderRadius.circular(8)),
          child: child),
    );
  }
}

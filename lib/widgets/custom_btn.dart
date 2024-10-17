import 'package:flutter/material.dart';

import '/helper/global.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomBtn({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          minimumSize: Size(
            mq.width * .4,
            50,
          ),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptativeButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: onPressed(),
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.purple),
            onPressed: () {},
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}

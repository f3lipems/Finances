import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.label,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              placeholder: label,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(labelText: label),
          );
  }
}

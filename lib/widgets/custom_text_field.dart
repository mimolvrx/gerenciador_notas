import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxlines; // quantidade de linhas no campo pode exibir

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.maxlines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxlines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

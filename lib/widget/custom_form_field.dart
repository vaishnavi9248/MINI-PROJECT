import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    this.onSubmit,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        label: Text(label),
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      validator: validator,
      onFieldSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit!(value);
        }
      },
    );
  }
}

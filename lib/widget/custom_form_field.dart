import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    this.onSubmit,
    this.isDense = true,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmit;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          label: Text(label),
          border: const OutlineInputBorder(),
          alignLabelWithHint: true,
          isDense: isDense,
        ),
        validator: validator,
        onFieldSubmitted: (value) {
          if (onSubmit != null) {
            onSubmit!(value);
          }
        },
      ),
    );
  }
}

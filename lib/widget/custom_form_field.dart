import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.admissionNo,
    required this.label,
    this.validator,
  }) : super(key: key);

  final TextEditingController admissionNo;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: admissionNo,
      decoration: InputDecoration(
        hintText: label,
        label: Text(label),
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      validator: validator,
    );
  }
}

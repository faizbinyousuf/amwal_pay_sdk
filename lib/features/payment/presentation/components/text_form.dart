import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isNumeric;
  final int? maxLength;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  const TextForm({
    Key? key,
    required this.title,
    required this.controller,
    this.isNumeric = false,
    this.maxLength,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(
          height: 50,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter $title',
            ),
            onChanged: onChanged,
            controller: controller,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            maxLength: maxLength,
            validator: validator,
          ),
        ),
      ],
    );
  }
}

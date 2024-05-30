import 'package:flutter/material.dart';

Widget customTextField({
  required String label,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.blueGrey),
    ),
    keyboardType: keyboardType,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value!.isEmpty) {
        return 'This field is required';
      } else if (label == 'Email') {
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      } else if (label == 'Phone Number') {
        if (!RegExp(r'^\d{11}$').hasMatch(value)) {
          return 'Please enter a valid 11-digit phone number';
        }
      }
      return null;
    },
  );
}

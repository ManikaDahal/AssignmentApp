import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final String? value;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  const CustomDropDown({
    Key? key,
    required this.labelText,
    required this.items,
    this.value,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        validator: validator,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}

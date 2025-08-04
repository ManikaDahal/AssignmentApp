
import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/color_uitils.dart';
import 'package:project_1/custom_widgets/custom_text.dart';

class CustomDropdown extends StatefulWidget {
  List<String> dropDownItemList;
  Function(String?)? onChanged;
  String? labelText;
  String? hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
    String? value;
  TextEditingController? controller;
  String? Function(String?)? validator;
  CustomDropdown(
      {super.key,
       required this.dropDownItemList,
      this.onChanged,
      this.labelText,
      this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.controller,
      this.validator,
      this.value});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            data: widget.labelText!,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField(
               value: widget.value != null && widget.dropDownItemList.contains(widget.value) ? widget.value : null,
              dropdownColor:Colors.grey,
              focusNode: _focusNode,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: primaryColor)),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon,
                  labelText: widget.labelText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
              items: widget.dropDownItemList
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: CustomText(
                        data: e,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: widget.onChanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
          
              ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_1/core/uitils/color_uitils.dart';

class CustomText extends StatelessWidget {
  String data;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  bool? isFormTitle ;
  bool? isPageTitle;

  CustomText(
      {super.key,
      required this.data,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.isFormTitle,
      this.isPageTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      softWrap: true,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
          color: color ?? blackColor,
          fontSize: isPageTitle?? false?20:isFormTitle ?? false ?28:fontSize ,
          fontWeight:(isPageTitle==true || isFormTitle ==true)?FontWeight.bold: fontWeight),
    );
  }
}
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function()? onPressed;
  Widget? child;
  Color? backgroundColor;
  CustomButton({super.key, this.onPressed, this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.95,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                  backgroundColor: backgroundColor ?? const Color.fromARGB(255, 171, 216, 237)),
              onPressed: onPressed,
              child: child)),
              
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final Color? iconColor;
  final Widget? imageIcon;
  final double? iconSize;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.icon,
    this.iconColor,
    this.imageIcon,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        icon: imageIcon ??
            (icon != null
                ? Icon(
              icon,
              color: iconColor ?? textColor ?? Colors.white,
              size: iconSize ?? 24, // Set default size to 24
            )
                : const SizedBox.shrink()),
        label: Text(
          text,
          style: TextStyle(color: textColor ?? Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}





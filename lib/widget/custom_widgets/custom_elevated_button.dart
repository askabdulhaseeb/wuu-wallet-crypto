import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.title,
    required this.onTap,
    this.applyGradient = true,
    this.readOnly = false,
    this.margin,
    this.padding,
    this.bgColor,
    this.borderRadius,
    this.border,
    this.textStyle,
    Key? key,
  }) : super(key: key);
  final String title;
  final bool readOnly;
  final bool applyGradient;
  final VoidCallback onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: readOnly ? Colors.transparent : Theme.of(context).primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        border: border,
      ),
      child: Material(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        color: Colors.transparent,
        child: readOnly
            ? Container(
                padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: textStyle ??
                      const TextStyle(
                        color: Colors.white24,
                        fontSize: 18,
                      ),
                ),
              )
            : InkWell(
                borderRadius: borderRadius ?? BorderRadius.circular(20),
                onTap: onTap,
                child: Container(
                  padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: textStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullWidthButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? buttonChild;
  const FullWidthButton({
    super.key,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    required this.title,
    this.buttonChild,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: backgroundColor ??
              Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        child: Center(
            child: buttonChild ??
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor ??
                          Theme.of(context).colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,),
                )),
      ),
    );
  }
}

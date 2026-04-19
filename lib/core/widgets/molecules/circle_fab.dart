import 'package:flutter/material.dart';
import 'package:ruay_jung/core/core.dart';

class CircleFab extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final double elevation;

  const CircleFab({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 56,
    this.backgroundColor,
    this.iconColor,
    this.elevation = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? context.theme.colorScheme.primary,
      shape: const CircleBorder(),
      elevation: elevation,
      shadowColor: AppPalette.natural.shade50,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(width: size, height: size, child: icon),
      ),
    );
  }
}

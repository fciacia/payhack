import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blur;
  final Color? backgroundColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 24,
    this.blur = 18,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: (backgroundColor ?? Colors.white.withOpacity(0.18)),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
} 
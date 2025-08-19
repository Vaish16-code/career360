// lib/widgets/app_logo.dart
import 'package:flutter/material.dart';
import '../theme.dart';

enum LogoVariant { app, login, student, mentor }

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.variant, this.size = 72});

  final LogoVariant variant;
  final double size;

  IconData _iconFor(LogoVariant v) {
    switch (v) {
      case LogoVariant.app:
        return Icons.hub_rounded; // app mark
      case LogoVariant.login:
        return Icons.lock_rounded; // login
      case LogoVariant.student:
        return Icons.school_rounded; // student
      case LogoVariant.mentor:
        return Icons.psychology_alt_rounded; // mentor
    }
  }

  List<Color> _colorsFor(LogoVariant v) {
    switch (v) {
      case LogoVariant.app:
        return const [kGradientStart, kGradientEnd];
      case LogoVariant.login:
        return const [Color(0xFF7C4DFF), Color(0xFF536DFE)];
      case LogoVariant.student:
        return const [Color(0xFF00BFA6), Color(0xFF00ACC1)];
      case LogoVariant.mentor:
        return const [Color(0xFFFF6F61), Color(0xFFFF8A65)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(variant);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: colors),
        boxShadow: [
          BoxShadow(
            color: colors.last.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Icon(_iconFor(variant), color: Colors.white, size: size * 0.5),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lingua_latina/theme/app_theme.dart';

class RomanLogo extends StatelessWidget {
  const RomanLogo({super.key, this.size = 92});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.softGold, AppTheme.bordeaux],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: const [
          BoxShadow(color: Color(0x337A1E2B), blurRadius: 16, offset: Offset(0, 8)),
        ],
      ),
      child: const Icon(Icons.account_balance, color: Colors.white, size: 46),
    );
  }
}

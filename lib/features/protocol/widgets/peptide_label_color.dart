import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

const kPeptideLabelColorHexes = <String>[
  '#05D9E8',
  '#FF2A6D',
  '#FCEE0A',
  '#BB44FF',
  '#39FF88',
  '#FF9F1C',
  '#7CFFCB',
  '#8A7CFF',
];

String defaultPeptideLabelColorHex(int index) {
  return kPeptideLabelColorHexes[index % kPeptideLabelColorHexes.length];
}

Color peptideLabelColor(String hex) {
  final normalized = hex.trim().replaceFirst('#', '');
  if (normalized.length != 6) return AppColors.primary;
  final value = int.tryParse(normalized, radix: 16);
  if (value == null) return AppColors.primary;
  return Color(0xFF000000 | value);
}

class PeptideLabelSwatch extends StatelessWidget {
  const PeptideLabelSwatch({
    super.key,
    required this.hex,
    this.size = 12,
    this.borderColor,
  });

  final String hex;
  final double size;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final color = peptideLabelColor(hex);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor ?? color.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: size * 0.8,
          ),
        ],
      ),
    );
  }
}

class PeptideLabelAvatar extends StatelessWidget {
  const PeptideLabelAvatar({
    super.key,
    required this.hex,
    this.icon = Icons.biotech_rounded,
  });

  final String hex;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final color = peptideLabelColor(hex);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Icon(icon, color: color),
    );
  }
}

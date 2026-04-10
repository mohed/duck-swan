import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _BirdPicker extends StatelessWidget {
  final List<IBird> birds;
  final IBird selected;
  final ValueChanged<IBird?> onChanged;

  const _BirdPicker({
    super.key,
    required this.birds,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2230),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF4A4E5C), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<IBird>(
          value: birds.contains(selected) ? selected : null,
          hint: Text(
            'Select a bird',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              letterSpacing: 3.0,
              color: const Color(0xFF6B7080),
            ),
          ),
          dropdownColor: const Color(0xFF1E2230),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF6B7080),
            size: 20,
          ),
          isExpanded: true,
          items: birds.map((bird) {
            return DropdownMenuItem<IBird>(
              value: bird,
              child: Text(
                bird.displayName.toUpperCase(),
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9BA3B2),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

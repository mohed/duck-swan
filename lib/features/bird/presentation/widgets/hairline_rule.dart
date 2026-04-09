import 'package:flutter/material.dart';

class HairlineRule extends StatelessWidget {
  const HairlineRule({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Container(height: 0.5, color: const Color(0xFF4A4E5C)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                '·',
                style: TextStyle(
                  color: Color(0xFF4A4E5C),
                  fontSize: 12,
                  height: 1,
                ),
              ),
            ),
            Expanded(
              child: Container(height: 0.5, color: const Color(0xFF4A4E5C)),
            ),
          ],
        ),
      ),
    );
  }
}

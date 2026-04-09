import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_bloc.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_event.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_state.dart';
import 'package:duck_swan/features/bird/presentation/widgets/top_row_animated_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF181B25),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;
            const divH = 16.0;
            final titleH = (h * 0.25 - divH).clamp(0.0, double.infinity);
            final imageH = h * 0.25;
            final bottomH = (h * 0.50 - divH).clamp(0.0, double.infinity);

            return Column(
              children: [
                // Title zone
                SizedBox(
                  height: titleH,
                  child: SafeArea(
                    bottom: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 0.5,
                                color: const Color(0xFF4A4E5C),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'DUCK & SWAN',
                                style: GoogleFonts.dmSans(
                                  fontSize: 26,
                                  letterSpacing: 5.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFFE8DFC0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 0.5,
                                color: const Color(0xFF4A4E5C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: divH, child: const _HairlineRule()),

                // Image zone
                SizedBox(
                  height: imageH,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: TopRowAnimatedView(),
                  ),
                ),

                SizedBox(height: divH, child: const _HairlineRule()),

                // Bottom zone
                SizedBox(
                  height: bottomH,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '"Tread with care and linger long,\nto catch a glimpse or hear a song."',
                            style: GoogleFonts.dmSans(
                              fontSize: 16,
                              color: const Color(0xFF9BA3B2),
                              height: 1.75,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          BlocBuilder<BirdBloc, BirdState>(
                            builder: (context, state) {
                              final bloc = context.read<BirdBloc>();
                              return _BirdPicker(
                                birds: bloc.availableBirds,
                                selected: state.currentBird,
                                onChanged: (bird) =>
                                    bloc.add(BirdSelected(bird!)),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          BlocBuilder<BirdBloc, BirdState>(
                            builder: (context, state) => _ActionButton(
                              label: state.currentBird.isAnimatable
                                  ? state.currentBird.doAction()
                                  : '· · ·',
                              enabled: state.currentBird.isAnimatable,
                              onTap: () => context
                                  .read<BirdBloc>()
                                  .add(const ActionPressed()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _HairlineRule extends StatelessWidget {
  const _HairlineRule();

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

class _BirdPicker extends StatelessWidget {
  final List<IBird> birds;
  final IBird selected;
  final ValueChanged<IBird?> onChanged;

  const _BirdPicker({
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
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF6B7080), size: 20),
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

class _ActionButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF4A90D9);
    return Opacity(
      opacity: enabled ? 1.0 : 0.4,
      child: SizedBox(
      width: double.infinity,
      child: Material(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          splashColor: color.withValues(alpha: 0.25),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: color.withValues(alpha: 0.4), width: 1.5),
            ),
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3.5,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}

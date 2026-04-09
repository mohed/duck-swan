import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_bloc.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_event.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_state.dart';
import 'package:duck_swan/features/bird/presentation/widgets/action_button.dart';
import 'package:duck_swan/features/bird/presentation/widgets/bird_picker.dart';
import 'package:duck_swan/features/bird/presentation/widgets/hairline_rule.dart';
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
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

                SizedBox(height: divH, child: const HairlineRule()),

                // Image zone
                SizedBox(
                  height: imageH,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: TopRowAnimatedView(),
                  ),
                ),

                SizedBox(height: divH, child: const HairlineRule()),

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
                              return BirdPicker(
                                birds: bloc.availableBirds,
                                selected: state.currentBird,
                                onChanged: (bird) =>
                                    bloc.add(BirdSelected(bird!)),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          BlocBuilder<BirdBloc, BirdState>(
                            builder: (context, state) => ActionButton(
                              label: state.currentBird.isAnimatable
                                  ? state.currentBird.doAction()
                                  : '· · ·',
                              enabled: state.currentBird.isAnimatable,
                              onTap: () => context.read<BirdBloc>().add(
                                const ActionPressed(),
                              ),
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

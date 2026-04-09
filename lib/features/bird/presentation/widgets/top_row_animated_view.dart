import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duck_swan/features/bird/domain/entities/bird_watching.dart';
import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_bloc.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_state.dart';

class TopRowAnimatedView extends StatefulWidget {
  const TopRowAnimatedView({super.key});

  @override
  State<TopRowAnimatedView> createState() => _TopRowAnimatedViewState();
}

class _TopRowAnimatedViewState extends State<TopRowAnimatedView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _frameAnimation;
  List<String> _frames = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _configureForBird(const BirdWatching());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _configureForBird(IBird bird) {
    _frames = bird.getAssetPaths();
    _controller.duration = Duration(milliseconds: 150 * _frames.length);
    _frameAnimation = StepTween(begin: 0, end: _frames.length).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BirdBloc, BirdState>(
      listener: (context, state) {
        _configureForBird(state.currentBird);
        if (state.isAnimating) {
          _controller.repeat();
        } else {
          _controller.stop();
          _controller.reset();
        }
      },
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final frame = _frameAnimation.value.clamp(0, _frames.length - 1);
            return ColoredBox(
              color: const Color(0xFF181B25),
              child: ShaderMask(
                blendMode: BlendMode.dstIn,
                shaderCallback: (bounds) => const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.12, 0.88, 1.0],
                ).createShader(bounds),
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (bounds) => RadialGradient(
                    center: Alignment.center,
                    radius: 0.75,
                    colors: [Colors.white, Colors.white, Colors.transparent],
                    stops: const [0.0, 0.35, 1.0],
                  ).createShader(bounds),
                  child: SizedBox.expand(
                    child: Image.asset(
                      _frames[frame],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.none,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

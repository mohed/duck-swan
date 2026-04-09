import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';

class BirdWatching extends IBird {
  const BirdWatching();

  @override
  String doAction() => '';

  @override
  String get displayName => '';

  @override
  List<String> getAssetPaths() => const ['images/bird_watching.png'];

  @override
  bool get isAnimatable => false;
}

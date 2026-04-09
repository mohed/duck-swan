import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';

class Duck extends IBird {
  const Duck();

  @override
  String doAction() => 'QUACK';

  @override
  String get displayName => 'Duck';

  @override
  List<String> getAssetPaths() =>
      List.generate(4, (i) => 'images/duck_${i + 1}.png');
}

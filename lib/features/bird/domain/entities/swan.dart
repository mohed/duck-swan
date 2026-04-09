import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';

class Swan extends IBird {
  const Swan();

  @override
  String doAction() => 'FLY';

  @override
  String get displayName => 'Swan';

  @override
  List<String> getAssetPaths() => const [
        'images/swan_flight.png',
        'images/swan_flight_2.png',
        'images/swan_flight_3.png',
        'images/swan_flight_4.png',
        'images/swan_flight_5.png',
      ];
}

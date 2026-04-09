import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';

abstract interface class IBirdRepository {
  List<IBird> getAvailableBirds();
}

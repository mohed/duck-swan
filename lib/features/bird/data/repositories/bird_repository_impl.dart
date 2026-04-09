import 'package:duck_swan/features/bird/domain/entities/duck.dart';
import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';
import 'package:duck_swan/features/bird/domain/entities/swan.dart';
import 'package:duck_swan/features/bird/domain/repositories/i_bird_repository.dart';

class BirdRepositoryImpl implements IBirdRepository {
  @override
  List<IBird> getAvailableBirds() => const [Duck(), Swan()];
}

import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';
import 'package:duck_swan/features/bird/domain/repositories/i_bird_repository.dart';

class GetAvailableBirds {
  final IBirdRepository _repository;

  const GetAvailableBirds(this._repository);

  List<IBird> call() => _repository.getAvailableBirds();
}

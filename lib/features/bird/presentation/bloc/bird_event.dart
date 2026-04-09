import 'package:equatable/equatable.dart';
import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';

sealed class BirdEvent extends Equatable {
  const BirdEvent();

  @override
  List<Object> get props => [];
}

final class BirdSelected extends BirdEvent {
  final IBird bird;

  const BirdSelected(this.bird);

  @override
  List<Object> get props => [bird];
}

final class ActionPressed extends BirdEvent {
  const ActionPressed();
}

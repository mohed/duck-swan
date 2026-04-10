import 'package:equatable/equatable.dart';
import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';

class BirdState extends Equatable {
  final IBird currentBird;
  final bool isAnimating;

  const BirdState({
    required this.currentBird,
    required this.isAnimating,
  });

  BirdState copyWith({IBird? currentBird, bool? isAnimating}) {
    return BirdState(
      currentBird: currentBird ?? this.currentBird,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }

  @override
  List<Object> get props => [currentBird];
}

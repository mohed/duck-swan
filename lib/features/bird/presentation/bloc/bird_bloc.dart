import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duck_swan/features/bird/domain/entities/bird_watching.dart';
import 'package:duck_swan/features/bird/domain/entities/i_bird.dart';
import 'package:duck_swan/features/bird/domain/usecases/get_available_birds.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_event.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_state.dart';

class BirdBloc extends Bloc<BirdEvent, BirdState> {
  final List<IBird> availableBirds;

  /// Public constructor — calls the use case exactly once via the private constructor.
  BirdBloc(GetAvailableBirds getAvailableBirds)
      : this._init(getAvailableBirds());

  BirdBloc._init(List<IBird> birds)
      : availableBirds = birds,
        super(const BirdState(currentBird: BirdWatching(), isAnimating: false)) {
    on<BirdSelected>(_onBirdSelected);
    on<ActionPressed>(_onActionPressed);
  }

  void _onBirdSelected(BirdSelected event, Emitter<BirdState> emit) {
    emit(BirdState(currentBird: state.currentBird, isAnimating: false));
  }

  void _onActionPressed(ActionPressed event, Emitter<BirdState> emit) {
    if (!state.currentBird.isAnimatable) return;
    state.currentBird.doAction();
    emit(state.copyWith(isAnimating: true));
  }
}

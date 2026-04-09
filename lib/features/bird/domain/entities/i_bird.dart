import 'package:equatable/equatable.dart';

abstract class IBird extends Equatable {
  const IBird();

  /// Returns the action label for this bird (e.g. "QUACK", "FLY").
  String doAction();

  /// Returns the ordered list of asset paths for this bird's animation frames.
  List<String> getAssetPaths();

  /// Human-readable name shown in the picker.
  String get displayName;

  /// Whether pressing the Action button should trigger animation.
  /// Defaults to true; `BirdWatching` overrides to false.
  bool get isAnimatable => true;

  @override
  List<Object> get props => [runtimeType];
}

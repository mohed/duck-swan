import 'package:get_it/get_it.dart';
import 'package:duck_swan/features/bird/data/repositories/bird_repository_impl.dart';
import 'package:duck_swan/features/bird/domain/repositories/i_bird_repository.dart';
import 'package:duck_swan/features/bird/domain/usecases/get_available_birds.dart';
import 'package:duck_swan/features/bird/presentation/bloc/bird_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // Repository
  sl.registerLazySingleton<IBirdRepository>(() => BirdRepositoryImpl());

  // Use case
  sl.registerLazySingleton(() => GetAvailableBirds(sl<IBirdRepository>()));

  // BLoC — factory so each BlocProvider gets a fresh instance
  sl.registerFactory(() => BirdBloc(sl<IBirdRepository>()));
}

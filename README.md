# Duck & Swan

A Flutter coding assignment for mid-level developers. The app lets you pick a bird (Duck or Swan) and trigger its action animation. It is intentionally small so the focus stays on architecture, not features.

## Tech stack

| Concern | Package |
|---------|---------|
| State management | `flutter_bloc` ^9.1.1 |
| Dependency injection | `get_it` ^8.0.3 |
| State equality | `equatable` ^2.0.7 |
| Fonts | `google_fonts` ^6.2.1 |

## Requirements

- Flutter **3.35.7**
- Dart **3.9.2**

## Getting started

```bash
flutter pub get
flutter run
```

## Architecture

Follows clean architecture with a strict layer boundary:

```
lib/
├── features/bird/
│   ├── domain/
│   │   ├── entities/       # IBird, Duck, Swan, BirdWatching
│   │   ├── repositories/   # IBirdRepository (interface)
│   │   └── usecases/       # GetAvailableBirds
│   ├── data/
│   │   └── repositories/   # BirdRepositoryImpl
│   └── presentation/
│       ├── bloc/           # BirdBloc, BirdEvent, BirdState
│       ├── pages/          # MainPage
│       └── widgets/        # BirdPicker, ActionButton, TopRowAnimatedView
└── injection_container.dart
```

The BLoC depends only on use cases. Use cases depend only on repository interfaces. No layer imports anything above it.

## Assignment notes

The codebase contains **4 deliberate bugs**. See [`BUGS.md`](BUGS.md) for locations, fixes, and the concepts each one tests (interviewer reference — do not share with candidates).

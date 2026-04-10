# Bug Report — duck_swan Coding Assignment

Four bugs have been deliberately introduced into this project. Candidates are expected to find and fix all of them within 30 minutes. The bugs span the three core pillars of the tech stack: **dependency injection (`get_it`)**, **BLoC pattern**, and **clean architecture / widget API**.

---

## Bug 1 — Compile error: wrong dependency type passed to BLoC

| Field    | Detail |
|----------|--------|
| **File** | `lib/injection_container.dart` |
| **Line** | 17 |

**Broken code**
```dart
sl.registerFactory(() => BirdBloc(sl<IBirdRepository>()));
```

**Fix**
```dart
sl.registerFactory(() => BirdBloc(sl<GetAvailableBirds>()));
```

**Intent**  
Tests whether the candidate understands two things simultaneously: (1) `sl<T>()` is a typed resolver whose generic argument must match the constructor's expected parameter type, and (2) a BLoC in clean architecture should depend on a **use case**, not directly on a repository. A candidate who "fixes" the compile error by changing `BirdBloc`'s constructor to accept `IBirdRepository` has misread the layer boundary — the correct repair is to fix the DI wiring.

---

## Bug 2 — Compile error: `BirdPicker` widget made private

| Field    | Detail |
|----------|--------|
| **File** | `lib/features/bird/presentation/widgets/bird_picker.dart` |
| **Line** | 5 |

**Broken code**
```dart
class _BirdPicker extends StatelessWidget {
```

**Fix**
```dart
class BirdPicker extends StatelessWidget {
```

**Intent**  
Tests awareness of Dart visibility rules. The leading underscore makes the class library-private, causing an "Undefined class 'BirdPicker'" error in `main_page.dart`. The symptom looks like a missing or mis-imported class, so the candidate must trace from the error site back to the declaration rather than hunting for a missing import. It also checks that they understand the difference between a public widget API and a private implementation detail.

---

## Bug 3 — Silent: `isAnimating` removed from `BirdState` Equatable props

| Field    | Detail |
|----------|--------|
| **File** | `lib/features/bird/presentation/bloc/bird_state.dart` |
| **Line** | 21 |

**Broken code**
```dart
List<Object> get props => [currentBird];
```

**Fix**
```dart
List<Object> get props => [currentBird, isAnimating];
```

**Intent**  
Tests deep understanding of `flutter_bloc`'s state-equality model. The app builds and runs. Selecting a bird works fine. Pressing the action button (**QUACK** / **FLY**) does nothing visible — no animation plays. Root cause: `_onActionPressed` emits `state.copyWith(isAnimating: true)`, but because `isAnimating` is absent from `props`, Equatable considers the new state equal to the current one. `flutter_bloc` skips the emission, `BlocConsumer.listener` in `TopRowAnimatedView` never fires, and `_controller.repeat()` is never called. Candidates must trace a "silent emit" all the way to the Equatable props list.

---

## Bug 4 — Silent: `_onBirdSelected` emits stale state instead of event payload

| Field    | Detail |
|----------|--------|
| **File** | `lib/features/bird/presentation/bloc/bird_bloc.dart` |
| **Line** | 23 |

**Broken code**
```dart
emit(BirdState(currentBird: state.currentBird, isAnimating: false));
```

**Fix**
```dart
emit(BirdState(currentBird: event.bird, isAnimating: false));
```

**Intent**  
Tests the classic "event vs. state" confusion that trips up mid-level BLoC developers. The app builds and runs. Tapping an entry in the bird picker appears to do nothing — the dropdown reverts to the `SELECT A BIRD` hint and the action button stays disabled. Root cause: the handler reads from `state.currentBird` (the current state, initially `BirdWatching`) rather than from `event.bird` (the payload the UI dispatched). Because the emitted state is Equatable-equal to the previous one, no rebuild occurs either. The candidate must trace the data flow from `BirdPicker.onChanged` → `bloc.add(BirdSelected(bird!))` → `_onBirdSelected` and recognise that `event` is the authoritative source of the selected value.

---

## Fix order for verification

1. Apply Bug 1 fix → `flutter analyze` passes.
2. Apply Bug 2 fix → app builds and launches.
3. With both compile errors fixed, the bird picker and action button are both broken (Bugs 3 & 4 are independent of each other).
4. Apply Bug 4 fix → dropdown selection now updates the displayed bird and enables the action button.
5. Apply Bug 3 fix → pressing the action button now triggers the animation loop.
6. All features working → matches the original `master` state.

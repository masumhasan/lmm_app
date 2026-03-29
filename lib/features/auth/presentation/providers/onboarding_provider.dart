import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingStepProvider = StateProvider<int>((ref) => 0);

class OnboardingController extends AutoDisposeNotifier<int> {
  @override
  int build() => 0;

  void next() {
    state++;
  }

  void previous() {
    if (state > 0) state--;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Incremented each time the user taps the Now tab from the bottom nav.
/// RTNOrchestrator listens to this and resets its step to 0.
final nowResetProvider = StateProvider<int>((ref) => 0);

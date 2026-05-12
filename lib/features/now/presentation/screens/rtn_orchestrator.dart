import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/core/providers/nav_reset_providers.dart';
import 'rtn_screens.dart';

class RTNOrchestrator extends ConsumerStatefulWidget {
  final bool accessedFromWorkout;
  const RTNOrchestrator({this.accessedFromWorkout = false, super.key});

  @override
  ConsumerState<RTNOrchestrator> createState() => _RTNOrchestratorState();
}

class _RTNOrchestratorState extends ConsumerState<RTNOrchestrator> {
  int currentStep = 0;

  void _onNext() {
    setState(() => currentStep++);
  }

  void _onBack() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    } else {
      context.pop();
    }
  }

  void _onHome() {
    setState(() => currentStep = 0);
    context.go('/');
  }

  void _onBackToWorkout() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(nowResetProvider, (prev, next) {
      if (prev != null && prev != next) {
        setState(() => currentStep = 0);
      }
    });

    switch (currentStep) {
      case 0:
        return RTN01EntryScreen(onNext: _onNext, onBack: _onBack);
      case 1:
        return RTN02VisualScreen(onNext: _onNext, onBack: _onBack);
      case 2:
        return RTN03AudioScreen(onNext: _onNext, onBack: _onBack);
      case 3:
        return RTN04PhysicalScreen(onNext: _onNext, onBack: _onBack);
      case 4:
        return RTN05ExitScreen(
          onHome: _onHome,
          onBackToWorkout: widget.accessedFromWorkout ? _onBackToWorkout : null,
        );
      default:
        return const Scaffold(body: Center(child: Text('Step Error')));
    }
  }
}

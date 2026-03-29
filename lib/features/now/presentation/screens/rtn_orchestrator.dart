import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'rtn_screens.dart';

class RTNOrchestrator extends StatefulWidget {
  final bool accessedFromWorkout;
  const RTNOrchestrator({this.accessedFromWorkout = false, super.key});

  @override
  State<RTNOrchestrator> createState() => _RTNOrchestratorState();
}

class _RTNOrchestratorState extends State<RTNOrchestrator> {
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
    context.go('/');
  }

  void _onBackToWorkout() {
    // If not from workout, this button won't show.
    // If it was from workout, we just pop back twice or go back to /workouts
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
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

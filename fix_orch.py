def update_orchestrator():
    with open('lib/features/workouts/presentation/screens/workout0/workout0_orchestrator.dart', 'r', encoding='utf-8') as f:
        text = f.read()

    target = '''      // --- Closing Sequence ---
      case 16:
        return const ClosingMainScreen();'''
        
    replacement = '''      case 16:
        return Workout0PennyScreen(
          text1: 'Small inputs create big loops.',
          text2: 'Silence the input, stop the loop.',
          repLoggedText: 'Loop Disruption',
          onNext: _onNext,
          onBack: _onBack,
        );

      // --- Closing Sequence ---
      case 17:
        return const ClosingMainScreen();'''

    text = text.replace(target, replacement)
    text = text.replace('static const int _totalSteps = 17;', 'static const int _totalSteps = 18;')

    with open('lib/features/workouts/presentation/screens/workout0/workout0_orchestrator.dart', 'w', encoding='utf-8') as f:
        f.write(text)

update_orchestrator()

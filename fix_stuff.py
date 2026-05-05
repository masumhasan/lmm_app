def update_drill1():
    with open('lib/features/workouts/presentation/screens/workout0/drills/drill1_reflex_screen.dart', 'r', encoding='utf-8') as f:
        text = f.read()

    text = text.replace("'DO NOT TAP ANYTHING'", "'LET IT HAPPEN. JUST WATCH IT.'")

    intro_screen = '''
class Drill1IntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Drill1IntroScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '? Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.zap,
            size: 48,
            color: AppColors.accent.withOpacity(0.2),
          ),
          const SizedBox(height: 32),
          Text(
            'Your attention will try to move before you choose.',
            style: AppTypography.h1.copyWith(
              fontSize: 34,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
'''
    if 'class Drill1IntroScreen' not in text:
        text += intro_screen

    with open('lib/features/workouts/presentation/screens/workout0/drills/drill1_reflex_screen.dart', 'w', encoding='utf-8') as f:
        f.write(text)

update_drill1()

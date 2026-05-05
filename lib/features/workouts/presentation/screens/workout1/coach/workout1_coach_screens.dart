import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/workout1_content_layout.dart';

/// Workout1_Coach_Disclaimer
class Workout1CoachDisclaimerScreen extends StatelessWidget {
  final VoidCallback onNext;
  const Workout1CoachDisclaimerScreen({required this.onNext, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Learn My Mind is an educational, self-guided system.\n\n'
                'It is not therapy, medical advice, or a substitute for professional support.\n\n'
                'If you feel unsafe, seek help from a qualified professional.',
                style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.6), height: 1.7),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                onPressed: onNext,
                child: Text('I Understand & Continue', style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Workout1_Coach_Intro
class Workout1CoachIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1CoachIntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ See How It Works',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Coach Mode',
            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Understanding Stories',
            style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'A structured guide for separating story from evidence.',
            style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.line.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Icon(LucideIcons.messageSquare, size: 32, color: AppColors.accent.withOpacity(0.3)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.lock, size: 12, color: AppColors.ink.withOpacity(0.2)),
                    const SizedBox(width: 6),
                    Text(
                      'Preview Only',
                      style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.3)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Workout1_Coach_Cards
class Workout1CoachCardsScreen extends StatelessWidget {
  final void Function(int cardIndex) onCardTap;
  final VoidCallback onBack;
  const Workout1CoachCardsScreen({required this.onCardTap, required this.onBack, super.key});

  static const _cards = [
    {'title': 'My thoughts scare me', 'teaser': 'Because stories arrive sounding like facts…'},
    {'title': 'How do I stop overthinking?', 'teaser': 'Because interruption starts with identification…'},
    {'title': 'I felt embarrassed today', 'teaser': 'Because meaning often outweighs the event…'},
    {'title': 'Why does my mind jump to the worst?', 'teaser': 'Because uncertainty activates prediction…'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onBack,
                child: Row(
                  children: [
                    Icon(LucideIcons.arrowLeft, size: 14, color: AppColors.ink.withOpacity(0.3)),
                    const SizedBox(width: 8),
                    Text('BACK', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('How Your Best Friend Helps', style: AppTypography.h2.copyWith(fontSize: 24)),
              const SizedBox(height: 8),
              Text(
                'Preview only — conversations unlock later',
                style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.25)),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.separated(
                  itemCount: _cards.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onCardTap(index),
                      child: FadeInUp(
                        delay: Duration(milliseconds: 200 * index),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.line.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _cards[index]['title']!,
                                      style: AppTypography.h2.copyWith(fontSize: 18, fontStyle: FontStyle.italic),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _cards[index]['teaser']!,
                                      style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.3)),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(LucideIcons.lock, size: 14, color: AppColors.ink.withOpacity(0.15)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Guided conversations unlock in Layer B.',
                  style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.2)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Workout1_Coach_Response — Shows sample guidance for a selected card
class Workout1CoachResponseScreen extends StatelessWidget {
  final int cardIndex;
  final VoidCallback onBack;
  final VoidCallback? onContinue;
  const Workout1CoachResponseScreen({required this.cardIndex, required this.onBack, this.onContinue, super.key});

  static const _responses = [
    'Thoughts feel convincing\nbecause they arrive as conclusions.\n\n'
        'Your system generates fast interpretations\nbefore checking evidence.\n\n'
        'Separate the sentence from sensation.\n\nAsk:\nWhat was the exact sentence?\nWhat proof supports it?\n\n'
        'Stories weaken under examination.',
    'Overthinking is repetitive meaning-making.\n\n'
        'Interruption begins with labeling.\n"This is a story."\n\n'
        'Distance reduces automatic escalation.\n\nThen check:\nEvidence — or imagination?',
    'Embarrassment often comes from interpretation.\n\n'
        'Separate event from meaning.\n'
        'Event: observable facts.\nMeaning: system-generated conclusion.\n\n'
        'Intensity usually belongs to the meaning.\nClarity reduces escalation.',
    'Uncertainty activates prediction.\n\n'
        'The system prefers over-warning\nto under-preparing.\n\n'
        'Catch the story.\nCheck the evidence.\nName the uncertainty.\n\nPrediction is not proof.',
  ];

  @override
  Widget build(BuildContext context) {
    final isLast = cardIndex == 3;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Coach Mode — Sample Guidance', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.2))),
                  Text('Preview • Read-Only', style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.2))),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: FadeIn(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.line.withOpacity(0.2)),
                      ),
                      child: Text(
                        _responses[cardIndex],
                        style: AppTypography.p.copyWith(fontSize: 15, height: 1.7, color: AppColors.ink.withOpacity(0.7)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: isLast
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        ),
                        onPressed: onContinue,
                        child: Text('Continue', style: AppTypography.btnText.copyWith(color: Colors.white)),
                      )
                    : TextButton(
                        onPressed: onBack,
                        child: Text(
                          '← Back to Cards',
                          style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.4)),
                        ),
                      ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Workout1_Coach_End
class Workout1CoachEndScreen extends StatelessWidget {
  final VoidCallback onHome;
  const Workout1CoachEndScreen({required this.onHome, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This Is How Guidance Works',
                style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                "This isn't a chat yet.\n"
                'This is how Learn My Mind breaks stories into clear steps.\n'
                'For now, continue training separation.',
                style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.5), height: 1.6),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                onPressed: () => context.go('/hub'),
                child: Text('Go to Tools Hub', style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  side: BorderSide(color: AppColors.ink.withOpacity(0.1)),
                ),
                onPressed: onHome,
                child: Text('Return to Home', style: AppTypography.btnText.copyWith(color: AppColors.ink.withOpacity(0.5))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

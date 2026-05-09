import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class _LibraryCard {
  final String title;
  final String subtitle;
  final String introLine;
  final String content;
  final String? closingLine;
  final String? exampleStory;
  final String? exampleReality;
  final String? simpleRule;

  const _LibraryCard({
    required this.title,
    required this.subtitle,
    required this.introLine,
    required this.content,
    this.closingLine,
    this.exampleStory,
    this.exampleReality,
    this.simpleRule,
  });
}

const _libraryCards = [
  _LibraryCard(
    title: 'Stories vs Reality',
    subtitle: 'Why thoughts feel true even when they\'re guesses.',
    introLine: 'Your system explains before it checks.',
    content:
        'Your system doesn\'t wait for facts.\nIt fills gaps with meaning.\n\n'
        'When something is unclear, it creates a story —\nnot to confuse you, but to protect you.\n\n'
        'Stories feel real because they use your own voice.\nReality feels quieter — but calmer.\n\n'
        'A story sounds urgent.\nReality simply is.',
    closingLine: 'Understanding weakens fear.',
    exampleStory: 'They didn\'t reply — I must have done something wrong.',
    exampleReality: 'I don\'t have enough information.',
  ),
  _LibraryCard(
    title: 'Why the Mind Guesses Danger',
    subtitle: 'How protection turns into prediction.',
    introLine: 'Prediction feels safer than uncertainty.',
    content:
        'Your system evolved to predict threats.\n'
        'In the past, guessing wrong could be dangerous.\n\n'
        'So your mind learned a rule:\nBetter to over-warn than miss something.\n\n'
        'This is why it jumps to conclusions.\nNot because you\'re anxious —\nbut because your system is cautious.\n\n'
        'False alarms feel uncomfortable,\nbut they are not harmful.',
    closingLine: 'Overprotection is not danger.',
  ),
  _LibraryCard(
    title: 'Evidence vs Imagination',
    subtitle: 'The difference that changes stress.',
    introLine: 'Stress lives in imagination.',
    content:
        'Evidence is what you can see, hear, or confirm.\n'
        'Imagination is what your system predicts.\n\n'
        'The mind treats both the same —\nunless you slow it down.\n\n'
        'When imagination leads, fear grows.\nWhen evidence leads, the story loses momentum.\n\n'
        'You don\'t need proof that everything is okay.\n'
        'You only need to notice when proof is missing.',
    simpleRule: 'If you don\'t have observable evidence — it\'s interpretation.',
  ),
  _LibraryCard(
    title: 'Why One Thought Becomes a Spiral',
    subtitle: 'How uncertainty grows momentum.',
    introLine: 'Unanswered thoughts create momentum.',
    content:
        'A single thought isn\'t the problem.\nFollowing it is.\n\n'
        'When a thought feels unresolved,\nyour system repeats it — louder each time.\n\n'
        'Repetition creates urgency.\nUrgency creates stress.\n\n'
        'Spirals don\'t mean something is wrong.\n'
        'They mean the system hasn\'t been interrupted yet.\n\n'
        'Awareness is the interruption.',
    closingLine: 'Noticing stops momentum.',
  ),
  _LibraryCard(
    title: 'Why Your Mind Repeats the Same Stories',
    subtitle: 'Repetition creates familiarity — not truth.',
    introLine: 'Familiar feels safer than unknown.',
    content:
        'Your subconscious follows what\'s familiar —\nnot what\'s true.\n\n'
        'If a story has appeared many times,\nit becomes the default.\n\n'
        'This doesn\'t mean the story is correct.\nIt means it\'s been repeated.\n\n'
        'Each time you notice a story without believing it,\nthe pattern weakens.\n\n'
        'New familiarity begins with awareness.',
    closingLine: 'Repetition can be retrained.',
  ),
];

/// Workout1 Library Menu
class Workout1LibraryMenuScreen extends StatelessWidget {
  final void Function(int cardIndex) onCardTap;
  final VoidCallback onBack;
  const Workout1LibraryMenuScreen({required this.onCardTap, required this.onBack, super.key});

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
              Text('Library', style: AppTypography.h1.copyWith(fontSize: 34, fontStyle: FontStyle.italic)),
              const SizedBox(height: 8),
              Text(
                'Understand how stories are created — without needing to do anything.',
                style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.4)),
              ),
              const SizedBox(height: 16),
              Text(
                'WORKOUT 1 — UNDERSTANDING THE STORIES',
                style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.25), letterSpacing: 2.0),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: _libraryCards.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onCardTap(index),
                      child: FadeInUp(
                        delay: Duration(milliseconds: 100 * index),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.line.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: AppTypography.mono.copyWith(fontSize: 12, color: AppColors.accent),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _libraryCards[index].title,
                                      style: AppTypography.h2.copyWith(fontSize: 17, fontStyle: FontStyle.italic),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _libraryCards[index].subtitle,
                                      style: AppTypography.p.copyWith(fontSize: 12, color: AppColors.ink.withOpacity(0.3)),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(LucideIcons.chevronRight, size: 16, color: AppColors.ink.withOpacity(0.15)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: onBack,
                    child: Text('◀ Back', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                  ),
                  const SizedBox(width: 24),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: Text('Exit to Home', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// Workout1 Library Detail Screen
class Workout1LibraryDetailScreen extends StatelessWidget {
  final int cardIndex;
  final VoidCallback onBack;
  const Workout1LibraryDetailScreen({required this.cardIndex, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    final card = _libraryCards[cardIndex];

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
              FadeIn(
                child: Text(card.title, style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic)),
              ),
              const SizedBox(height: 8),
              Text(
                '"${card.introLine}"',
                style: AppTypography.p.copyWith(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.ink.withOpacity(0.4)),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.content,
                        style: AppTypography.p.copyWith(fontSize: 15, height: 1.7, color: AppColors.ink.withOpacity(0.7)),
                      ),
                      if (card.exampleStory != null) ...[
                        const SizedBox(height: 32),
                        Container(height: 1, color: AppColors.line.withOpacity(0.3)),
                        const SizedBox(height: 24),
                        Text('Example:', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                        const SizedBox(height: 12),
                        Text(
                          'Story:\n"${card.exampleStory}"',
                          style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.5)),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Reality:\n"${card.exampleReality}"',
                          style: AppTypography.p.copyWith(fontSize: 14, color: const Color(0xFF10B981).withOpacity(0.7)),
                        ),
                      ],
                      if (card.simpleRule != null) ...[
                        const SizedBox(height: 32),
                        Container(height: 1, color: AppColors.line.withOpacity(0.3)),
                        const SizedBox(height: 24),
                        Text('Simple Rule:', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                        const SizedBox(height: 8),
                        Text(
                          card.simpleRule!,
                          style: AppTypography.p.copyWith(fontSize: 14, fontStyle: FontStyle.italic, color: AppColors.ink.withOpacity(0.5)),
                        ),
                      ],
                      if (card.closingLine != null) ...[
                        const SizedBox(height: 32),
                        Text(
                          '"${card.closingLine}"',
                          style: AppTypography.p.copyWith(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.ink.withOpacity(0.3)),
                        ),
                      ],
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: onBack,
                    child: Text('◀ Back to Library', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                  ),
                  const SizedBox(width: 24),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: Text('Exit to Home', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

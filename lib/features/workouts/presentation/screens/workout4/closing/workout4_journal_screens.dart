import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout4_content_layout.dart';

class Workout4JournalIntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4JournalIntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Begin Reflection',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            child: Text('Reflect on Today',
                style: AppTypography.h1.copyWith(fontSize: 34),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          FadeIn(
            delay: const Duration(milliseconds: 600),
            child: Text('This locks in the interruption skill.',
                style: AppTypography.p
                    .copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5)),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

class Workout4JournalPromptScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onBack;
  const Workout4JournalPromptScreen(
      {required this.onNext, required this.onSkip, required this.onBack, super.key});

  @override
  State<Workout4JournalPromptScreen> createState() =>
      _Workout4JournalPromptScreenState();
}

class _Workout4JournalPromptScreenState
    extends State<Workout4JournalPromptScreen> {
  final _ctrl1 = TextEditingController();
  final _ctrl2 = TextEditingController();
  final _ctrl3 = TextEditingController();
  final Set<String> _tags = {};

  static const _tagList = [
    'Overthinking', 'Work', 'Social', 'Health', 'Future', 'Unknown'
  ];

  void _toggleTag(String t) =>
      setState(() => _tags.contains(t) ? _tags.remove(t) : _tags.add(t));

  @override
  void dispose() {
    _ctrl1.dispose();
    _ctrl2.dispose();
    _ctrl3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onBack,
                  child: Row(children: [
                    Icon(LucideIcons.arrowLeft,
                        size: 14, color: AppColors.ink.withOpacity(0.3)),
                    const SizedBox(width: 8),
                    Text('BACK',
                        style: AppTypography.columnHeader
                            .copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                  ]),
                ),
                Text('Training Log — Workout 4',
                    style: AppTypography.columnHeader
                        .copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.2))),
              ],
            ),
            const SizedBox(height: 48),
            FadeIn(
              child: Text('Complete these three lines.',
                  style: AppTypography.h2
                      .copyWith(fontSize: 22, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(height: 8),
            FadeIn(
              delay: const Duration(milliseconds: 400),
              child: Text(
                'No explanation. No analysis. Just the interruption.',
                style: AppTypography.columnHeader.copyWith(
                    fontSize: 9, color: AppColors.ink.withOpacity(0.3)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            _PromptField(
              label: 'The thought that appeared',
              placeholder: 'What if…',
              controller: _ctrl1,
            ),
            const SizedBox(height: 20),
            _PromptField(
              label: 'How I labeled it',
              placeholder: 'Overthinking / Future noise / Mental replay',
              controller: _ctrl2,
            ),
            const SizedBox(height: 20),
            _PromptField(
              label: 'What I did instead',
              placeholder: 'Returned to task / Stayed present / Did nothing',
              controller: _ctrl3,
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _tagList
                  .map((t) => _TagChip(
                        tag: t,
                        isSelected: _tags.contains(t),
                        onTap: () => _toggleTag(t),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 56),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                ),
                onPressed: widget.onNext,
                child: Text('Save Reflection',
                    style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: widget.onSkip,
                child: Text('Skip for Now',
                    style: AppTypography.columnHeader.copyWith(
                      fontSize: 10,
                      color: AppColors.ink.withOpacity(0.3),
                      decoration: TextDecoration.underline,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromptField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;

  const _PromptField({
    required this.label,
    required this.placeholder,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.columnHeader.copyWith(
                fontSize: 9,
                color: AppColors.ink.withOpacity(0.4),
                letterSpacing: 1.5)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle:
                AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.2)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.line.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.line.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String tag;
  final bool isSelected;
  final VoidCallback onTap;
  const _TagChip({required this.tag, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.line.withOpacity(0.2),
          ),
        ),
        child: Text(tag.toUpperCase(),
            style: AppTypography.columnHeader.copyWith(
              fontSize: 8,
              color: isSelected ? AppColors.accent : AppColors.ink.withOpacity(0.4),
            )),
      ),
    );
  }
}

class Workout4JournalConfirmScreen extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onHome;
  const Workout4JournalConfirmScreen(
      {required this.onContinue, required this.onHome, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeIn(
                child: Text('This interruption is recorded.',
                    style: AppTypography.h2
                        .copyWith(fontSize: 26, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 12),
              FadeIn(
                delay: const Duration(milliseconds: 600),
                child: Text('Repetition makes it automatic.',
                    style: AppTypography.p.copyWith(
                        fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 40),
              FadeIn(
                delay: const Duration(milliseconds: 1000),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        onPressed: onContinue,
                        child: Text('Continue to Skill Reps',
                            style: AppTypography.btnText
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          side: BorderSide(color: AppColors.ink.withOpacity(0.12)),
                        ),
                        onPressed: onHome,
                        child: Text('Return Home',
                            style: AppTypography.btnText.copyWith(
                                color: AppColors.ink.withOpacity(0.5))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

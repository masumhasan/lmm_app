import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum OnboardingStepType { welcome, bulletPoints, listItems, negativePoints }

class OnboardingStepModel {
  final int stepIndex;
  final String title;
  final OnboardingStepType type;
  final List<String>? mainPoints;
  final List<OnboardingItem>? listItems;
  final String? subtitle;
  final String? footerText;
  final String? buttonLabel;
  final IconData? welcomeIcon;

  OnboardingStepModel({
    required this.stepIndex,
    required this.title,
    required this.type,
    this.mainPoints,
    this.listItems,
    this.subtitle,
    this.footerText,
    this.buttonLabel = 'Continue',
    this.welcomeIcon,
  });

  static List<OnboardingStepModel> steps = [
    OnboardingStepModel(
      stepIndex: 0,
      title: 'LearnMyMind',
      subtitle: 'Train the mind you live in.',
      type: OnboardingStepType.welcome,
      welcomeIcon: LucideIcons.brain,
      buttonLabel: 'Begin',
    ),
    OnboardingStepModel(
      stepIndex: 1,
      title: 'What This Is',
      type: OnboardingStepType.bulletPoints,
      mainPoints: [
        'A structured mental training system.',
        'Built around cognitive workouts.',
        'Designed to strengthen attention and separation.',
      ],
    ),
    OnboardingStepModel(
      stepIndex: 2,
      title: 'What This Isn\'t',
      type: OnboardingStepType.negativePoints,
      mainPoints: [
        'Not therapy.',
        'Not medical advice.',
        'Not emotional support.',
        'Not a quick fix.',
      ],
      footerText: 'IT DOES NOT CHANGE HOW YOU FEEL. IT TRAINS WHERE ATTENTION GOES.',
    ),
    OnboardingStepModel(
      stepIndex: 3,
      title: 'How Training Works',
      type: OnboardingStepType.listItems,
      listItems: [
        OnboardingItem(
          icon: LucideIcons.zap,
          title: 'WORKOUTS',
          description: 'Structured cognitive sessions.',
        ),
        OnboardingItem(
          icon: LucideIcons.checkCircle,
          title: 'SKILL REPS',
          description: 'Short drills that strengthen control.',
        ),
        OnboardingItem(
          icon: LucideIcons.layoutGrid,
          title: 'TRAINING LOG',
          description: 'Track what you noticed.',
        ),
      ],
      footerText: 'REPETITION BUILDS AUTOMATIC STRENGTH.',
    ),
    OnboardingStepModel(
      stepIndex: 4,
      title: 'Three Ways to Train',
      type: OnboardingStepType.listItems,
      listItems: [
        OnboardingItem(
          icon: LucideIcons.zap,
          title: 'WORKOUTS',
          description: 'Build core mental muscles.',
        ),
        OnboardingItem(
          icon: LucideIcons.refreshCw,
          title: 'RETURN TO NOW',
          description: 'Neutral attention reset.',
        ),
        OnboardingItem(
          icon: LucideIcons.wind,
          title: 'DRIFT',
          description: 'Pattern exposure through media.',
        ),
      ],
    ),
  ];
}

class OnboardingItem {
  final IconData icon;
  final String title;
  final String description;

  OnboardingItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

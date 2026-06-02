import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum OnboardingStepType { 
  welcome, 
  bulletPoints, 
  listItems, 
  negativePoints, 
  simpleBody,
  createAccount 
}

class OnboardingStepModel {
  final int stepIndex;
  final String title;
  final OnboardingStepType type;
  final List<String>? mainPoints;
  final List<OnboardingItem>? listItems;
  final String? body;
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
    this.body,
    this.subtitle,
    this.footerText,
    this.buttonLabel = 'Continue',
    this.welcomeIcon,
  });

  static List<OnboardingStepModel> steps = [
    OnboardingStepModel(
      stepIndex: 1,
      title: ' ',
      subtitle: 'Train the mind you live in.',
      type: OnboardingStepType.welcome,
      welcomeIcon: LucideIcons.brain,
      buttonLabel: 'Begin',
      footerText: 'Not therapy.\nNot motivation.\nNot emotional support.\nTraining.',
    ),
    OnboardingStepModel(
      stepIndex: 2,
      title: 'What This Is',
      type: OnboardingStepType.simpleBody,
      body: 'A structured cognitive training system.\n\nBuilt around:\n attention • interruption • separation\n & \n awareness under pressure\n\n“Designed to strengthen recognition before automatic reaction.”',
      buttonLabel: 'Continue',
    ),
    OnboardingStepModel(
      stepIndex: 3,
      title: 'What This Isn\'t',
      type: OnboardingStepType.negativePoints,
      mainPoints: [
        'Not therapy.',
        'Not medical advice.',
        'Not emotional support.',
        'Not a quick fix.',
      ],
      footerText: 'It does not change how you feel.\nIt trains where attention goes.',
      buttonLabel: 'Continue',
    ),
    OnboardingStepModel(
      stepIndex: 4,
      title: 'How Training Works',
      type: OnboardingStepType.listItems,
      listItems: [
        OnboardingItem(
          icon: LucideIcons.zap,
          title: 'WORKOUTS',
          description: 'Structured cognitive training sessions.',
        ),
        OnboardingItem(
          icon: LucideIcons.checkCircle,
          title: 'SKILL REPS',
          description: 'Short training games that reinforce recognition and interruption.',
        ),
        OnboardingItem(
          icon: LucideIcons.layoutGrid,
          title: 'TRAINING LOG',
          description: 'Record replay, interruption, and awareness patterns.',
        ),
      ],
      footerText: 'Repetition builds automatic strength.',
      buttonLabel: 'Continue',
    ),
    OnboardingStepModel(
      stepIndex: 5,
      title: 'What Starts Changing',
      type: OnboardingStepType.simpleBody,
      body: '"You may still experience:\n• thoughts\n• replay\n• uncertainty\n• sensations\n• urgency\n\nBut there\'s a higher chance you\'ll:\n• notice patterns sooner\n• interrupt automatic reactions earlier\n• see replay before it fully runs\n• recognize when attention gets captured\n• respond with more choice inside the moment"',
      buttonLabel: 'Continue',
    ),
    OnboardingStepModel(
      stepIndex: 6,
      title: 'Three Ways to Train',
      type: OnboardingStepType.listItems,
      listItems: [
        OnboardingItem(
          icon: LucideIcons.zap,
          title: 'WORKOUTS',
          description: 'Build core cognitive muscles.',
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
      buttonLabel: 'Continue',
    ),
    OnboardingStepModel(
      stepIndex: 7,
      title: 'Create Account',
      type: OnboardingStepType.createAccount,
      buttonLabel: 'Enter Training Floor',
      footerText: 'I understand this is an educational training system.',
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

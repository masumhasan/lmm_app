import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:just_audio/just_audio.dart';

class SystemDetailedDefinitionScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const SystemDetailedDefinitionScreen({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  State<SystemDetailedDefinitionScreen> createState() =>
      _SystemDetailedDefinitionScreenState();
}

class _SystemDetailedDefinitionScreenState
    extends State<SystemDetailedDefinitionScreen> {
  bool shieldFaded = false;
  bool showMicroLine = false;
  bool showCTA = false;
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
    _runShieldAnimation();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audios/voiceovers/Workout0_System_Definition.mp3');
      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed && mounted) {
          setState(() => showMicroLine = true);
          Future.delayed(const Duration(milliseconds: 1400), () {
            if (mounted) setState(() => showCTA = true);
          });
        }
      });
      await _audioPlayer.play();
    } catch (_) {}
  }

  void _runShieldAnimation() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) setState(() => shieldFaded = true);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: widget.onNext,
      onBack: widget.onBack,
      showNextButton: showCTA,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 1000),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 800),
              crossFadeState: shieldFaded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Icon(
                LucideIcons.shield,
                size: 64,
                color: AppColors.accent.withOpacity(0.1),
              ),
              secondChild: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accent.withOpacity(0.12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          if (showMicroLine)
            FadeIn(
              duration: const Duration(milliseconds: 600),
              child: Text(
                'Protection \u2260 Truth',
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 10,
                  color: AppColors.accent,
                  letterSpacing: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

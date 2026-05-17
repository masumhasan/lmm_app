import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:just_audio/just_audio.dart';

class EduUntrainedScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const EduUntrainedScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<EduUntrainedScreen> createState() => _EduUntrainedScreenState();
}

class _EduUntrainedScreenState extends State<EduUntrainedScreen> {
  bool showLine1 = false;
  bool showLine2 = false;
  bool showLine3 = false;
  bool showCTA = false;
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
    _runSequence();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audios/voiceovers/Workout0_Education_Untrained.mp3');
      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed && mounted) {
          setState(() => showCTA = true);
        }
      });
      await _audioPlayer.play();
    } catch (_) {}
  }

  void _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => showLine1 = true);

    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => showLine2 = true);

    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => showLine3 = true);
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedOpacity(
            opacity: showLine1 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: Text(
              'You did not fail.',
              style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: showLine2 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: Text(
              'You were never trained',
              style: AppTypography.p.copyWith(
                fontSize: 20,
                color: AppColors.ink.withOpacity(0.55),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedOpacity(
            opacity: showLine3 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 600),
            child: Text(
              'to catch what happens automatically.',
              style: AppTypography.p.copyWith(
                fontSize: 20,
                color: AppColors.ink.withOpacity(0.55),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

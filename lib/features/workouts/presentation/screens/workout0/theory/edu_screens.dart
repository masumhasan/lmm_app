import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lmm_app/shared/widgets/theory_card.dart';
import 'package:just_audio/just_audio.dart';

class EduUntrainedScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const EduUntrainedScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<EduUntrainedScreen> createState() => _EduUntrainedScreenState();
}

class _EduUntrainedScreenState extends State<EduUntrainedScreen> {
  static const _items = ['FEAR', 'OVERTHINKING', 'PRESSURE', 'SELF-DOUBT'];
  int visibleCount = 0;
  bool showClosingLine = false;
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
    await Future.delayed(const Duration(milliseconds: 800));
    for (var i = 0; i < _items.length; i++) {
      if (!mounted) return;
      setState(() => visibleCount = i + 1);
      await Future.delayed(const Duration(milliseconds: 1400));
    }
    if (!mounted) return;
    setState(() => showClosingLine = true);
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
          ...List.generate(_items.length, (i) {
            if (i >= visibleCount) {
              return const SizedBox.shrink();
            }
            return FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: TheoryCard(
                child: Text(
                  _items[i],
                  style: AppTypography.columnHeader.copyWith(
                    fontSize: 10,
                    letterSpacing: 2.0,
                    color: AppColors.ink.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            );
          }),
          if (showClosingLine) ...[
            const SizedBox(height: 40),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Text(
                'And everything that comes with being human.',
                style: AppTypography.p.copyWith(
                  fontSize: 16,
                  color: AppColors.ink.withOpacity(0.4),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

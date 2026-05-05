import 'package:flutter/material.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:just_audio/just_audio.dart';

class TrainingSystemRuleScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const TrainingSystemRuleScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<TrainingSystemRuleScreen> createState() => _TrainingSystemRuleScreenState();
}

class _TrainingSystemRuleScreenState extends State<TrainingSystemRuleScreen> {
  bool showCTA = false;
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audios/voiceovers/Workout0_TrainingSystem_Rule.mp3');
      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed && mounted) {
          setState(() => showCTA = true);
        }
      });
      await _audioPlayer.play();
    } catch (_) {}
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
          Text(
            'Your training system doesn\u2019t follow what is true.\nIt follows what is repeated.',
            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

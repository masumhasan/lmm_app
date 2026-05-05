import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';

class Workout0EntryScreen extends StatefulWidget {
  final VoidCallback onNext;
  const Workout0EntryScreen({required this.onNext, super.key});

  @override
  State<Workout0EntryScreen> createState() => _Workout0EntryScreenState();
}

class _Workout0EntryScreenState extends State<Workout0EntryScreen> {
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
      await _audioPlayer.setAsset('assets/audios/ambient/Workout0_Entry.mp3');
      await _audioPlayer.setLoopMode(LoopMode.one);
      await _audioPlayer.play();
    } catch (_) {}
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => showLine1 = true);

    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => showLine2 = true);

    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => showLine3 = true);

    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted) return;
    setState(() => showCTA = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7F5F2),
              Color(0xFFEDE9E3),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 24,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.arrowLeft,
                      size: 14,
                      color: AppColors.ink.withOpacity(0.3),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'BACK',
                      style: AppTypography.columnHeader.copyWith(
                        fontSize: 10,
                        color: AppColors.ink.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.ink.withOpacity(0.12),
                      ),
                    ),
                    const SizedBox(height: 48),
                    AnimatedOpacity(
                      opacity: showLine1 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        'Your attention moves fast.',
                        style: AppTypography.h1.copyWith(
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: showLine2 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        'Usually before you notice.',
                        style: AppTypography.p.copyWith(
                          fontSize: 18,
                          color: AppColors.ink.withOpacity(0.45),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: showLine3 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        'Today you\u2019ll catch it.',
                        style: AppTypography.h2.copyWith(
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (showCTA)
              Positioned(
                bottom: 80,
                left: 48,
                right: 48,
                child: AnimatedOpacity(
                  opacity: showCTA ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 0,
                    ),
                    onPressed: widget.onNext,
                    child: Text(
                      'Begin Workout',
                      style: AppTypography.btnText.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

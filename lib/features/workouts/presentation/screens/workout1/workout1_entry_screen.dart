import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:animate_do/animate_do.dart';
import 'package:just_audio/just_audio.dart';

class Workout1EntryScreen extends StatefulWidget {
  final VoidCallback onNext;
  const Workout1EntryScreen({required this.onNext, super.key});

  @override
  State<Workout1EntryScreen> createState() => _Workout1EntryScreenState();
}

class _Workout1EntryScreenState extends State<Workout1EntryScreen> {
  bool _showLine2 = false;
  bool _showLine3 = false;
  bool _showCTA = false;
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
    
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _showLine2 = true);
    });
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) setState(() => _showLine3 = true);
    });
    Future.delayed(const Duration(milliseconds: 3400), () {
      if (mounted) setState(() => _showCTA = true);
    });
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/audios/ambient/Workout1_Entry.mp3');
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Subtle gradient background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.3),
                  radius: 1.4,
                  colors: [
                    AppColors.accent.withOpacity(0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  FadeIn(
                    duration: const Duration(milliseconds: 800),
                    child: Text(
                      'The story forms fast.',
                      style: AppTypography.h2.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _showLine2 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: Text(
                      'Usually before it is questioned.',
                      style: AppTypography.p.copyWith(
                        fontSize: 16,
                        color: AppColors.ink.withOpacity(0.4),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedOpacity(
                    opacity: _showLine3 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: Text(
                      'Today you catch it forming.',
                      style: AppTypography.p.copyWith(
                        fontSize: 16,
                        color: AppColors.ink.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  AnimatedOpacity(
                    opacity: _showCTA ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        ),
                        onPressed: _showCTA ? widget.onNext : null,
                        child: Text(
                          '   Begin Workout',
                          style: AppTypography.btnText.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

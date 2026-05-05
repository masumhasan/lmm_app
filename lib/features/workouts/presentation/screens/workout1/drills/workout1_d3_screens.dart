import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

/// Workout1_D3_Play1 — Author Shift (first person)
class Workout1D3Play1Screen extends StatefulWidget {
  final VoidCallback onNext;
  const Workout1D3Play1Screen({required this.onNext, super.key});

  @override
  State<Workout1D3Play1Screen> createState() => _Workout1D3Play1ScreenState();
}

class _Workout1D3Play1ScreenState extends State<Workout1D3Play1Screen> {
  bool _showPrompt = false;
  bool _detecting = false;
  int _detectedMs = 0;
  Timer? _detectionTimer;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _detectedMs < 2000) {
        setState(() => _showPrompt = true);
      }
    });
    _startDetection();
  }

  void _startDetection() {
    _detectionTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_detecting) {
        _detectedMs += 100;
        if (_detectedMs >= 2000) {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 400), () {
            if (mounted) widget.onNext();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _detectionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _detecting = true),
      onTapUp: (_) => setState(() => _detecting = false),
      onTapCancel: () => setState(() => _detecting = false),
      onLongPressStart: (_) => setState(() => _detecting = true),
      onLongPressEnd: (_) => setState(() => _detecting = false),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Stack(
          children: [
            Positioned(
              top: 80,
              left: 32,
              right: 32,
              child: Text(
                'COGNITIVE DISTANCE',
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 9,
                  color: AppColors.ink.withOpacity(0.2),
                  letterSpacing: 3.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeIn(
                      child: Text(
                        'This is going to go badly.',
                        style: AppTypography.h1.copyWith(fontSize: 30, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Say it exactly as written.',
                      style: AppTypography.p.copyWith(
                        fontSize: 14,
                        color: AppColors.ink.withOpacity(0.4),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (_showPrompt && _detectedMs < 2000) ...[
                      const SizedBox(height: 24),
                      FadeIn(
                        child: Text(
                          'Say it out loud.',
                          style: AppTypography.p.copyWith(
                            fontSize: 13,
                            color: AppColors.ink.withOpacity(0.3),
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    const SizedBox(height: 48),
                    Text(
                      'Hold anywhere while speaking',
                      style: AppTypography.columnHeader.copyWith(
                        fontSize: 9,
                        color: AppColors.ink.withOpacity(0.2),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        value: (_detectedMs / 2000).clamp(0.0, 1.0),
                        backgroundColor: AppColors.line.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _detecting
                              ? const Color(0xFF10B981)
                              : AppColors.ink.withOpacity(0.15),
                        ),
                        minHeight: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Workout1_D3_Play2 — Author Shift (third person)
class Workout1D3Play2Screen extends StatefulWidget {
  final VoidCallback onNext;
  const Workout1D3Play2Screen({required this.onNext, super.key});

  @override
  State<Workout1D3Play2Screen> createState() => _Workout1D3Play2ScreenState();
}

class _Workout1D3Play2ScreenState extends State<Workout1D3Play2Screen> {
  bool _detecting = false;
  int _detectedMs = 0;
  Timer? _detectionTimer;

  @override
  void initState() {
    super.initState();
    _startDetection();
  }

  void _startDetection() {
    _detectionTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_detecting) {
        _detectedMs += 100;
        if (_detectedMs >= 2000) {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 400), () {
            if (mounted) widget.onNext();
          });
        }
        if (mounted) setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _detectionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _detecting = true),
      onTapUp: (_) => setState(() => _detecting = false),
      onTapCancel: () => setState(() => _detecting = false),
      onLongPressStart: (_) => setState(() => _detecting = true),
      onLongPressEnd: (_) => setState(() => _detecting = false),
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeIn(
                      child: Column(
                        children: [
                          Text(
                            'The system said,',
                            style: AppTypography.p.copyWith(
                              fontSize: 16,
                              color: AppColors.ink.withOpacity(0.4),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '"This is going to go badly."',
                            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Say it this way.',
                      style: AppTypography.p.copyWith(
                        fontSize: 14,
                        color: AppColors.ink.withOpacity(0.4),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    Text(
                      'Hold anywhere while speaking',
                      style: AppTypography.columnHeader.copyWith(
                        fontSize: 9,
                        color: AppColors.ink.withOpacity(0.2),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        value: (_detectedMs / 2000).clamp(0.0, 1.0),
                        backgroundColor: AppColors.line.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _detecting
                              ? const Color(0xFF10B981)
                              : AppColors.ink.withOpacity(0.15),
                        ),
                        minHeight: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

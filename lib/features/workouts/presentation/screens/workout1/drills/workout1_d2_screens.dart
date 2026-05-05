import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import '../widgets/workout1_content_layout.dart';

/// Workout1_D2_Intro — Distortion Under Pressure
class Workout1D2IntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout1D2IntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout1ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Begin',
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'STORY SEPARATION (INTERRUPTION UNDER PRESSURE)',
            style: AppTypography.columnHeader.copyWith(
              fontSize: 8,
              color: AppColors.ink.withOpacity(0.25),
              letterSpacing: 2.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Distortion Under Pressure',
            style: AppTypography.h1.copyWith(fontSize: 28, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Stories intensify fast.',
            style: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            "You're training interruption under pressure.",
            style: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Workout1_D2_Play — Timed build interaction
class Workout1D2PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout1D2PlayScreen({required this.onComplete, super.key});

  @override
  State<Workout1D2PlayScreen> createState() => _Workout1D2PlayScreenState();
}

class _Workout1D2PlayScreenState extends State<Workout1D2PlayScreen> {
  static const _lines = [
    'I made a small mistake.',
    'That was embarrassing.',
    'People noticed.',
    'This will affect how they see me.',
  ];

  final List<String> _visibleLines = [];
  double _intensity = 0.0;
  bool _isHolding = false;
  bool _isComplete = false;
  Timer? _lineTimer;
  Timer? _endTimer;
  int _elapsedMs = 0;
  static const _maxDurationMs = 12000;

  @override
  void initState() {
    super.initState();
    _startBuild();
  }

  void _startBuild() {
    _addNextLine();
  }

  void _addNextLine() {
    if (_isComplete || !mounted) return;
    if (_visibleLines.length >= _lines.length) {
      _scheduleEnd();
      return;
    }

    _lineTimer = Timer(const Duration(milliseconds: 1500), () {
      if (!mounted || _isComplete) return;
      if (_isHolding) {
        _lineTimer = Timer(const Duration(milliseconds: 500), () => _addNextLine());
        return;
      }
      setState(() {
        _visibleLines.add(_lines[_visibleLines.length]);
        _intensity = _visibleLines.length * 0.25;
      });
      _addNextLine();
    });
  }

  void _scheduleEnd() {
    final remaining = _maxDurationMs - _elapsedMs;
    _endTimer = Timer(Duration(milliseconds: remaining > 0 ? remaining : 500), () {
      if (mounted) {
        setState(() => _isComplete = true);
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) widget.onComplete();
        });
      }
    });
  }

  void _startTracking() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted || _isComplete) {
        timer.cancel();
        return;
      }
      if (!_isHolding) {
        _elapsedMs += 100;
      }
      if (_elapsedMs >= _maxDurationMs) {
        timer.cancel();
        setState(() => _isComplete = true);
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) widget.onComplete();
        });
      }
    });
  }

  @override
  void dispose() {
    _lineTimer?.cancel();
    _endTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_elapsedMs == 0) _startTracking();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isHolding = true),
      onTapUp: (_) => setState(() => _isHolding = false),
      onTapCancel: () => setState(() => _isHolding = false),
      onLongPressStart: (_) => setState(() => _isHolding = true),
      onLongPressEnd: (_) => setState(() => _isHolding = false),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1D2E),
        body: Stack(
          children: [
            Positioned(
              top: 80,
              left: 32,
              right: 32,
              child: Text(
                'Press and hold to slow the build.\nRelease to let it continue.',
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.3),
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < _visibleLines.length; i++)
                      FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            _visibleLines[i],
                            style: AppTypography.h2.copyWith(
                              fontSize: 22,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Intensity bar
            Positioned(
              right: 24,
              top: 140,
              bottom: 140,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: (MediaQuery.of(context).size.height - 280) * _intensity,
                    decoration: BoxDecoration(
                      color: _isHolding
                          ? Colors.white.withOpacity(0.2)
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
            if (_isHolding)
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: FadeIn(
                  child: Text(
                    'HOLDING',
                    style: AppTypography.columnHeader.copyWith(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.3),
                      letterSpacing: 3.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

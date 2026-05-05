import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

/// Workout1_SR2_Play — Certainty Dial
class Workout1SR2PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout1SR2PlayScreen({required this.onComplete, super.key});

  @override
  State<Workout1SR2PlayScreen> createState() => _Workout1SR2PlayScreenState();
}

class _Workout1SR2PlayScreenState extends State<Workout1SR2PlayScreen> {
  static const _cues = [
    'Seen ✓',
    'Short reply: "ok"',
    'Meeting moved earlier',
    'Pause before response',
  ];

  double _dialValue = 0.3;
  double _driftSpeed = 0.004;
  bool _isPaused = false;
  bool _isComplete = false;
  String? _currentCue;
  int _cueIndex = 0;
  int _elapsedMs = 0;
  // ignore: unused_field
  int _neutralMs = 0;
  Timer? _gameTimer;
  Timer? _cueTimer;

  static const _gameDurationMs = 20000;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _gameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_isPaused || !mounted) return;
      _elapsedMs += 50;

      setState(() {
        _dialValue += _driftSpeed;
        if (_dialValue >= 1.0) {
          _dialValue = 0.7;
        }
        if (_dialValue >= 0.4 && _dialValue <= 0.6) {
          _neutralMs += 50;
        }
      });

      if (_elapsedMs >= _gameDurationMs) {
        timer.cancel();
        _endGame();
      }
    });

    _scheduleCue();
  }

  void _scheduleCue() {
    _cueTimer = Timer(const Duration(seconds: 4), () {
      if (!mounted || _isComplete) return;
      setState(() {
        _currentCue = _cues[_cueIndex % _cues.length];
        _driftSpeed += 0.001;
      });
      _cueIndex++;
      Timer(const Duration(seconds: 2), () {
        if (mounted) setState(() => _currentCue = null);
      });
      if (!_isComplete) _scheduleCue();
    });
  }

  void _endGame() {
    setState(() => _isComplete = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) widget.onComplete();
    });
  }

  void _rotateCounterClockwise() {
    if (_isPaused || _isComplete) return;
    setState(() {
      _dialValue = (_dialValue - 0.05).clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _cueTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dialSize = MediaQuery.of(context).size.width * 0.6;
    final isInNeutral = _dialValue >= 0.4 && _dialValue <= 0.6;

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < 0 || details.delta.dy > 0) {
          _rotateCounterClockwise();
        }
      },
      onTap: _rotateCounterClockwise,
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1D2E),
        body: Stack(
          children: [
            // Pause button
            Positioned(
              top: 60,
              right: 24,
              child: GestureDetector(
                onTap: () => setState(() => _isPaused = !_isPaused),
                child: Icon(
                  _isPaused ? Icons.play_arrow : Icons.pause,
                  size: 24,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
            // Instruction
            Positioned(
              top: 100,
              left: 32,
              right: 32,
              child: Text(
                'Keep the dial inside the neutral band.\nTap or swipe to adjust.',
                style: AppTypography.p.copyWith(fontSize: 13, color: Colors.white.withOpacity(0.3)),
                textAlign: TextAlign.center,
              ),
            ),
            // Cue text
            if (_currentCue != null)
              Positioned(
                top: 170,
                left: 0,
                right: 0,
                child: FadeIn(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    _currentCue!,
                    style: AppTypography.p.copyWith(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.5),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            // Dial
            Center(
              child: SizedBox(
                width: dialSize,
                height: dialSize,
                child: CustomPaint(
                  painter: _DialPainter(
                    value: _dialValue,
                    isInNeutral: isInNeutral,
                  ),
                ),
              ),
            ),
            // Label
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Certainty',
                    style: AppTypography.columnHeader.copyWith(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.4),
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(_dialValue * 100).round()}%',
                    style: AppTypography.h1.copyWith(
                      fontSize: 36,
                      color: isInNeutral ? const Color(0xFF10B981) : Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            // Scale labels
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('0% Unclear', style: AppTypography.mono.copyWith(fontSize: 9, color: Colors.white.withOpacity(0.2))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('40-60%', style: AppTypography.mono.copyWith(fontSize: 9, color: const Color(0xFF10B981).withOpacity(0.5))),
                  ),
                  Text('100% Certain', style: AppTypography.mono.copyWith(fontSize: 9, color: Colors.white.withOpacity(0.2))),
                ],
              ),
            ),
            // Pause modal
            if (_isPaused)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: () => setState(() => _isPaused = false),
                      child: Text('▶ Resume', style: AppTypography.btnText.copyWith(color: AppColors.accent)),
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

class _DialPainter extends CustomPainter {
  final double value;
  final bool isInNeutral;

  _DialPainter({required this.value, required this.isInNeutral});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;

    // Background arc
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 0.75,
      pi * 1.5,
      false,
      bgPaint,
    );

    // Neutral band (40-60%)
    final neutralPaint = Paint()
      ..color = const Color(0xFF10B981).withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 0.75 + pi * 1.5 * 0.4,
      pi * 1.5 * 0.2,
      false,
      neutralPaint,
    );

    // Value indicator
    final valuePaint = Paint()
      ..color = isInNeutral ? const Color(0xFF10B981) : Colors.white.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 0.75,
      pi * 1.5 * value,
      false,
      valuePaint,
    );

    // Needle dot
    final angle = pi * 0.75 + pi * 1.5 * value;
    final needlePos = Offset(
      center.dx + radius * cos(angle),
      center.dy + radius * sin(angle),
    );

    canvas.drawCircle(
      needlePos,
      8,
      Paint()..color = isInNeutral ? const Color(0xFF10B981) : Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _DialPainter oldDelegate) =>
      value != oldDelegate.value || isInNeutral != oldDelegate.isInNeutral;
}

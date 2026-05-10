import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

/// Workout1_SR1_Play — Attention Lane
class Workout1SR1PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout1SR1PlayScreen({required this.onComplete, super.key});

  @override
  State<Workout1SR1PlayScreen> createState() => _Workout1SR1PlayScreenState();
}

class _Workout1SR1PlayScreenState extends State<Workout1SR1PlayScreen>
    with SingleTickerProviderStateMixin {
  static const _distractions = [
    'This is a sign.',
    "They're pulling away.",
    "You're behind.",
    "It's about to go wrong.",
  ];

  late AnimationController _dotController;
  bool _isPaused = false;
  bool _isComplete = false;
  bool _thumbOnDot = false;
  bool _laneFlashing = false;
  int _elapsedMs = 0;
  String? _currentDistraction;
  Timer? _gameTimer;
  Timer? _distractionTimer;
  Timer? _flashTimer;
  int _distractionIndex = 0;

  // Captured sine offset when thumb lands on dot
  double _frozenOffset = 0.0;

  // Animation duration in ms — shortened to speed up drift
  int _dotDurationMs = 3000;
  static const _minDurationMs = 1000;

  static const _gameDurationMs = 20000;
  static const _laneWidth = 80.0;

  @override
  void initState() {
    super.initState();
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _startGame();
  }

  void _startGame() {
    _gameTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isPaused || !mounted) return;
      _elapsedMs += 100;
      if (_elapsedMs >= _gameDurationMs) {
        timer.cancel();
        _endGame();
      }
    });
    _scheduleDistraction();
  }

  void _scheduleDistraction() {
    final delay = 4000 + Random().nextInt(1000);
    _distractionTimer = Timer(Duration(milliseconds: delay), () {
      if (!mounted || _isComplete) return;
      setState(() =>
          _currentDistraction = _distractions[_distractionIndex % _distractions.length]);
      _distractionIndex++;
      Timer(const Duration(seconds: 2), () {
        if (mounted) setState(() => _currentDistraction = null);
      });
      if (!_isComplete) _scheduleDistraction();
    });
  }

  // Thumb lands on dot → freeze dot at current position
  void _onThumbDown(double screenWidth) {
    final currentOffset =
        sin(_dotController.value * pi * 2) * (screenWidth * 0.25);
    _dotController.stop();
    setState(() {
      _thumbOnDot = true;
      _frozenOffset = currentOffset;
    });
  }

  // Thumb lifts → dot becomes unstable, drifts faster
  void _onThumbUp() {
    _increaseDotSpeed(delta: 400);
    setState(() => _thumbOnDot = false);
    if (!_isPaused && !_isComplete) {
      _dotController.repeat(reverse: true);
    }
  }

  // Thumb drifts outside lane boundary → soft flash + slight speed increase
  void _onThumbUpdate(DragUpdateDetails details, double laneCenter) {
    final x = details.globalPosition.dx;
    final outside =
        x < laneCenter - _laneWidth / 2 || x > laneCenter + _laneWidth / 2;
    if (outside && !_laneFlashing) {
      _triggerLaneFlash();
      _increaseDotSpeed(delta: 200);
    }
  }

  // Soft lane brightening — no red, just a brief white pulse
  void _triggerLaneFlash() {
    setState(() => _laneFlashing = true);
    _flashTimer?.cancel();
    _flashTimer = Timer(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _laneFlashing = false);
    });
  }

  // Shorten controller duration to increase drift speed
  void _increaseDotSpeed({required int delta}) {
    final next = (_dotDurationMs - delta).clamp(_minDurationMs, 3000);
    if (next != _dotDurationMs) {
      _dotDurationMs = next;
      _dotController.duration = Duration(milliseconds: _dotDurationMs);
    }
  }

  void _endGame() {
    setState(() => _isComplete = true);
    _dotController.stop();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _dotController.dispose();
    _gameTimer?.cancel();
    _distractionTimer?.cancel();
    _flashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final laneCenter = screenWidth / 2;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Stack(
        children: [
          // Pause button
          Positioned(
            top: 60,
            right: 24,
            child: GestureDetector(
              onTap: () {
                setState(() => _isPaused = !_isPaused);
                if (_isPaused) {
                  _dotController.stop();
                } else {
                  _dotController.repeat(reverse: true);
                }
              },
              child: Icon(
                _isPaused ? Icons.play_arrow : Icons.pause,
                size: 24,
                color: AppColors.ink.withOpacity(0.3),
              ),
            ),
          ),
          // Instruction
          Positioned(
            top: 100,
            left: 32,
            right: 32,
            child: Column(
              children: [
                Text(
                  'Stay Centered',
                  style: AppTypography.columnHeader.copyWith(
                    fontSize: 10,
                    color: AppColors.ink.withOpacity(0.3),
                    letterSpacing: 2.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Keep your thumb on the dot.\nKeep it inside the lane.',
                  style: AppTypography.p
                      .copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.3)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Lane — flashes softly when thumb exits boundary
          Positioned(
            top: 180,
            bottom: 100,
            left: laneCenter - _laneWidth / 2,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _laneWidth,
              decoration: BoxDecoration(
                color: _laneFlashing
                    ? Colors.white.withOpacity(0.88)
                    : Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: _laneFlashing
                      ? AppColors.accent.withOpacity(0.28)
                      : AppColors.line.withOpacity(0.3),
                ),
              ),
            ),
          ),
          // Moving dot
          AnimatedBuilder(
            animation: _dotController,
            builder: (context, child) {
              final offset = _thumbOnDot
                  ? _frozenOffset
                  : sin(_dotController.value * pi * 2) * (screenWidth * 0.25);
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                left: laneCenter - 16 + offset,
                child: GestureDetector(
                  onPanStart: (_) => _onThumbDown(screenWidth),
                  onPanUpdate: (details) => _onThumbUpdate(details, laneCenter),
                  onPanEnd: (_) => _onThumbUp(),
                  onPanCancel: () => _onThumbUp(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _thumbOnDot
                          ? AppColors.accent
                          : AppColors.accent.withOpacity(0.6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // Story distractions
          if (_currentDistraction != null)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: 0,
              right: 0,
              child: FadeIn(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _currentDistraction!,
                  style: AppTypography.h2.copyWith(
                    fontSize: 24,
                    color: AppColors.ink.withOpacity(0.08),
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          // Pause overlay
          if (_isPaused)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    onPressed: () {
                      setState(() => _isPaused = false);
                      _dotController.repeat(reverse: true);
                    },
                    child: Text('  Resume',
                        style:
                            AppTypography.btnText.copyWith(color: AppColors.accent)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

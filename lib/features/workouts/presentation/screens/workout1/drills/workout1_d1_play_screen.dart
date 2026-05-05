import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';


enum D1TapResult { none, earlyInterpretation, strongInterpretation, noTaps }

/// Workout1_D1_Play — Snap Detection game
class Workout1D1PlayScreen extends StatefulWidget {
  final void Function(D1TapResult result) onComplete;
  const Workout1D1PlayScreen({required this.onComplete, super.key});

  @override
  State<Workout1D1PlayScreen> createState() => _Workout1D1PlayScreenState();
}

class _Workout1D1PlayScreenState extends State<Workout1D1PlayScreen> {
  static const _fragments = [
    'They walked past.',
    'They walked past. Didn\'t look at me.',
    'They walked past. Didn\'t look at me. That felt deliberate.',
    'The meeting ended.',
    'The meeting ended. No one mentioned my idea.',
    'The meeting ended. No one mentioned my idea. They didn\'t value it.',
  ];

  static const _interpretationFragments = {1, 2, 4, 5};

  int _currentFragment = 0;
  bool _isActive = true;
  final Set<int> _tappedFragments = {};
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scheduleNext();
  }

  void _scheduleNext() {
    final delay = 900 + (_currentFragment * 60); // 900–1260ms range
    _timer = Timer(Duration(milliseconds: delay), () {
      if (!mounted || !_isActive) return;
      if (_currentFragment < _fragments.length - 1) {
        setState(() => _currentFragment++);
        _scheduleNext();
      } else {
        _finishDrill();
      }
    });
  }

  void _onTap() {
    if (!_isActive) return;

    _tappedFragments.add(_currentFragment);

    if (_interpretationFragments.contains(_currentFragment)) {
      HapticFeedback.lightImpact();
      _timer?.cancel();
      Timer(const Duration(milliseconds: 800), () {
        if (!mounted || !_isActive) return;
        if (_currentFragment < _fragments.length - 1) {
          setState(() => _currentFragment++);
          _scheduleNext();
        } else {
          _finishDrill();
        }
      });
    }
  }

  void _finishDrill() {
    setState(() => _isActive = false);

    final tappedInterpretations = _tappedFragments.intersection(_interpretationFragments);
    final onlyStrong = tappedInterpretations.every((f) => f == 2 || f == 5);

    D1TapResult result;
    if (tappedInterpretations.isEmpty) {
      result = D1TapResult.noTaps;
    } else if (onlyStrong && tappedInterpretations.isNotEmpty) {
      result = D1TapResult.strongInterpretation;
    } else {
      result = D1TapResult.earlyInterpretation;
    }

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) widget.onComplete(result);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 80,
              left: 32,
              right: 32,
              child: Text(
                'Tap the moment the sentence adds meaning.',
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 10,
                  color: AppColors.ink.withOpacity(0.3),
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Text(
                    _fragments[_currentFragment],
                    key: ValueKey(_currentFragment),
                    style: AppTypography.h2.copyWith(
                      fontSize: 22,
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Text(
                '${_currentFragment + 1} / ${_fragments.length}',
                style: AppTypography.mono.copyWith(
                  fontSize: 10,
                  color: AppColors.ink.withOpacity(0.15),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

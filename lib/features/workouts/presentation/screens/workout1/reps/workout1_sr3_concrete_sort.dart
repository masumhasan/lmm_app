import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

enum _CardType { story, concrete }

class _SortCard {
  final String text;
  final _CardType type;
  _SortCard(this.text, this.type);
}

/// Workout1_SR3_Play — Concrete Sort
class Workout1SR3PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout1SR3PlayScreen({required this.onComplete, super.key});

  @override
  State<Workout1SR3PlayScreen> createState() => _Workout1SR3PlayScreenState();
}

class _Workout1SR3PlayScreenState extends State<Workout1SR3PlayScreen> {
  late final List<_SortCard> _cards;
  int _currentIndex = 0;
  String? _feedbackText;
  bool _isPaused = false;
  bool _isComplete = false;
  Offset _cardOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _cards = [
      _SortCard("They don't respect me.", _CardType.story),
      _SortCard('Ask one clear question.', _CardType.concrete),
      _SortCard('This will fail.', _CardType.story),
      _SortCard('Confirm the time.', _CardType.concrete),
      _SortCard('I always mess this up.', _CardType.story),
      _SortCard('Wait for reply.', _CardType.concrete),
      _SortCard("They're judging.", _CardType.story),
      _SortCard('Write the next step.', _CardType.concrete),
      _SortCard("Check what's known.", _CardType.concrete),
    ]..shuffle(Random());
  }

  void _handleFlick(bool flickedUp) {
    if (_isPaused || _isComplete || _currentIndex >= _cards.length) return;

    final card = _cards[_currentIndex];
    final isStory = card.type == _CardType.story;

    if (flickedUp && isStory) {
      HapticFeedback.lightImpact();
      _advance();
    } else if (flickedUp && !isStory) {
      setState(() => _feedbackText = "That's actionable.");
      _clearFeedback();
    } else if (!flickedUp && !isStory) {
      HapticFeedback.lightImpact();
      _advance();
    } else if (!flickedUp && isStory) {
      setState(() => _feedbackText = 'That adds meaning.');
      _clearFeedback();
    }
  }

  void _clearFeedback() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _feedbackText = null;
          _cardOffset = Offset.zero;
        });
      }
    });
  }

  void _advance() {
    setState(() {
      _feedbackText = null;
      _cardOffset = Offset.zero;
      _currentIndex++;
    });
    if (_currentIndex >= _cards.length) {
      setState(() => _isComplete = true);
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) widget.onComplete();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
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
                color: AppColors.ink.withOpacity(0.3),
              ),
            ),
          ),
          // Instruction
          Positioned(
            top: 80,
            left: 32,
            right: 32,
            child: Text(
              'Flick UP to discard.\nFlick DOWN to keep.',
              style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.3)),
              textAlign: TextAlign.center,
            ),
          ),
          // Zone labels
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            child: Text(
              '↑ Discard Story',
              style: AppTypography.columnHeader.copyWith(
                fontSize: 10,
                color: AppColors.ink.withOpacity(0.15),
                letterSpacing: 2.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Text(
              '↓ Keep Concrete',
              style: AppTypography.columnHeader.copyWith(
                fontSize: 10,
                color: const Color(0xFF10B981).withOpacity(0.3),
                letterSpacing: 2.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Card
          if (!_isComplete && _currentIndex < _cards.length)
            Center(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() => _cardOffset += Offset(0, details.delta.dy));
                },
                onVerticalDragEnd: (details) {
                  if (_cardOffset.dy < -60) {
                    _handleFlick(true);
                  } else if (_cardOffset.dy > 60) {
                    _handleFlick(false);
                  } else {
                    setState(() => _cardOffset = Offset.zero);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  transform: Matrix4.translationValues(0, _cardOffset.dy, 0),
                  child: Container(
                    width: 280,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '"${_cards[_currentIndex].text}"',
                          style: AppTypography.h2.copyWith(fontSize: 20, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        if (_feedbackText != null) ...[
                          const SizedBox(height: 16),
                          FadeIn(
                            child: Text(
                              _feedbackText!,
                              style: AppTypography.columnHeader.copyWith(
                                fontSize: 10,
                                color: AppColors.ink.withOpacity(0.4),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          // Progress
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Text(
              '${_currentIndex} / ${_cards.length}',
              style: AppTypography.mono.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.15)),
              textAlign: TextAlign.center,
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
    );
  }
}

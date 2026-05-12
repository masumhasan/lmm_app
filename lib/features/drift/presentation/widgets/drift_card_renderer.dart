import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/features/drift/domain/models/drift_card_model.dart';
import 'package:animate_do/animate_do.dart';

class DriftCardRenderer extends StatefulWidget {
  final DriftCardModel card;
  final bool isActive;

  const DriftCardRenderer({
    super.key,
    required this.card,
    this.isActive = false,
  });

  @override
  State<DriftCardRenderer> createState() => _DriftCardRendererState();
}

class _DriftCardRendererState extends State<DriftCardRenderer> with WidgetsBindingObserver {
  int _currentLineIndex = 0;
  Timer? _timer;
  int? _secondsPerLine;

  @override
  void initState() {
    super.initState();
    _calculateTiming();
    WidgetsBinding.instance.addObserver(this);
    if (widget.isActive) {
      _startCard();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;
    if (state == AppLifecycleState.resumed) {
      if (widget.isActive) {
        _startCard();
      }
    } else if (state == AppLifecycleState.paused) {
      _stopCard();
    }
  }

  void _calculateTiming() {
    if (widget.card.textSequence.isNotEmpty) {
      _secondsPerLine = (widget.card.runtimeSeconds / widget.card.textSequence.length).floor();
      if (_secondsPerLine! < 1) _secondsPerLine = 1;
    }
  }

  @override
  void didUpdateWidget(DriftCardRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.card != oldWidget.card) {
      _calculateTiming();
    }
    if (widget.isActive && !oldWidget.isActive) {
      _startCard();
    } else if (!widget.isActive && oldWidget.isActive) {
      _stopCard();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  void _startCard() {
    if (_secondsPerLine == null || !mounted) return;
    
    setState(() {
      _currentLineIndex = 0;
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: _secondsPerLine!), (timer) {
      if (mounted) {
        setState(() {
          if (_currentLineIndex < widget.card.textSequence.length - 1) {
            _currentLineIndex++;
          } else {
            // Loop back to start
            _currentLineIndex = 0;
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _stopCard() {
    _timer?.cancel();
    _timer = null;
    if (mounted) {
      setState(() {
        _currentLineIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show static background if not active, or actual content if active
    return Container(
      color: const Color(0xFFF4F6FA),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: double.infinity,
      child: widget.isActive 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        ).drive(Tween<double>(begin: 0.98, end: 1.0)),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    widget.card.textSequence[_currentLineIndex],
                    key: ValueKey("${widget.card.id}_$_currentLineIndex"),
                    textAlign: TextAlign.center,
                    style: AppTypography.h2.copyWith(
                      color: const Color(0xFF2E3A59),
                      fontSize: 26,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink(),
    );
  }
}

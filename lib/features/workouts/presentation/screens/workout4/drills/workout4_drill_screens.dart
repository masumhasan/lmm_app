import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:animate_do/animate_do.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout4_content_layout.dart';

class Workout4Drill1EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4Drill1EntryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Remove the Fuel', style: AppTypography.h1.copyWith(fontSize: 34)),
          const SizedBox(height: 12),
          Text('Noise only runs while attention feeds it.', style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5))),
          const SizedBox(height: 32),
          Text('This drill trains one thing.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('Attention is fuel.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4Drill1PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout4Drill1PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout4Drill1PlayScreen> createState() => _Workout4Drill1PlayScreenState();
}

class _Workout4Drill1PlayScreenState extends State<Workout4Drill1PlayScreen> {
  // Shared hold progress (0.0 → 1.0) — drives thought slowdown and fade
  final ValueNotifier<double> _holdNotifier = ValueNotifier(0.0);

  bool isHolding = false;
  bool showContinue = false;
  Timer? _holdTimer;
  Timer? _buttonShowTimer;

  final List<String> thoughts = [
    'What if they meant...',
    'I should have said...',
    'Not good enough',
    'Tomorrow might be...',
    'Why did I do that?',
    'This won\'t work',
  ];

  void _startHold() {
    setState(() => isHolding = true);
    _holdTimer?.cancel();
    // Fill to 1.0 over 3 s (100ms × 30 steps)
    _holdTimer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      if (!isHolding || !mounted) { t.cancel(); return; }
      final next = (_holdNotifier.value + 1 / 30).clamp(0.0, 1.0);
      _holdNotifier.value = next;
      if (next >= 1.0) {
        t.cancel();
        if (mounted) setState(() => showContinue = true);
      }
    });
  }

  void _releaseHold() {
    setState(() => isHolding = false);
    _holdTimer?.cancel();
    if (!showContinue) {
      // Released before completing — thoughts resume at full speed
      _holdNotifier.value = 0.0;
    } else {
      // Already completed — hide button after 5 s if not re-held
      _buttonShowTimer?.cancel();
      _buttonShowTimer = Timer(const Duration(seconds: 5), () {
        if (mounted && !isHolding) {
          setState(() => showContinue = false);
          _holdNotifier.value = 0.0;
        }
      });
    }
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _buttonShowTimer?.cancel();
    _holdNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Left side: Drifting thoughts
          Positioned.fill(
            child: ValueListenableBuilder<double>(
              valueListenable: _holdNotifier,
              builder: (context, holdProgress, _) => FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (0.5 - holdProgress * 0.05).clamp(0.45, 0.5),
                child: ClipRect(
                  child: Stack(
                    children: [
                      for (int i = 0; i < thoughts.length; i++)
                        _DriftingThought(
                          text: thoughts[i],
                          initialProgress: i / thoughts.length,
                          holdNotifier: _holdNotifier,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Right side: Quiet zone
          Positioned.fill(
            child: ValueListenableBuilder<double>(
              valueListenable: _holdNotifier,
              builder: (context, holdProgress, _) => FractionallySizedBox(
                alignment: Alignment.centerRight,
                widthFactor: (0.5 + holdProgress * 0.05).clamp(0.5, 0.55),
                child: GestureDetector(
                onLongPressStart: (_) => _startHold(),
                onLongPressEnd: (_) => _releaseHold(),
                child: Container(
                  decoration: BoxDecoration(
                    color: isHolding ? AppColors.accent.withOpacity(0.05) : Colors.transparent,
                    border: Border(left: BorderSide(color: AppColors.line.withOpacity(0.1))),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isHolding ? 'HOLDING...' : 'HOLD HERE',
                          style: AppTypography.columnHeader.copyWith(fontSize: 12, letterSpacing: 2),
                        ),
                        const SizedBox(height: 12),
                        ValueListenableBuilder<double>(
                          valueListenable: _holdNotifier,
                          builder: (context, progress, _) => SizedBox(
                            width: 140,
                            height: 3,
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: AppColors.line.withOpacity(0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Text('Hold the quiet zone.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
          ),
          if (showContinue)
            Positioned(
              bottom: 64,
              left: 48,
              right: 48,
              child: FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Text('Noise runs when it\'s fed.', style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.45))),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ink,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      ),
                      onPressed: widget.onComplete,
                      child: Text('Continue', style: AppTypography.btnText.copyWith(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DriftingThought extends StatefulWidget {
  final String text;
  final double initialProgress;
  final ValueNotifier<double> holdNotifier;
  const _DriftingThought({required this.text, required this.initialProgress, required this.holdNotifier});
  @override
  _DriftingThoughtState createState() => _DriftingThoughtState();
}

class _DriftingThoughtState extends State<_DriftingThought> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late double _progress;
  int _lastMs = 0;
  bool _tickerStarted = false;
  static const double _cycleDurationMs = 14000.0;

  @override
  void initState() {
    super.initState();
    _progress = widget.initialProgress;
    _ticker = createTicker(_onTick);
    _ticker.start();
  }

  void _onTick(Duration elapsed) {
    if (!_tickerStarted) {
      _tickerStarted = true;
      _lastMs = elapsed.inMilliseconds;
      return;
    }
    final dt = elapsed.inMilliseconds - _lastMs;
    _lastMs = elapsed.inMilliseconds;
    // Speed scales down to zero as holdProgress reaches 1.0
    final speedFactor = (1.0 - widget.holdNotifier.value).clamp(0.0, 1.0);
    if (speedFactor < 0.001) return;
    setState(() {
      _progress += (dt / _cycleDurationMs) * speedFactor;
      if (_progress >= 1.0) _progress -= 1.0;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Map _progress (0→1) to the original range (-1.0→1.2)
    final animValue = -1.0 + _progress * 2.2;
    final baseOpacity = (1 - (animValue - 0.5).abs() * 2).clamp(0.0, 0.4);
    return ValueListenableBuilder<double>(
      valueListenable: widget.holdNotifier,
      builder: (context, holdProgress, _) {
        final opacity = (baseOpacity * (1.0 - holdProgress * 0.9)).clamp(0.0, 1.0);
        return Positioned(
          top: 200 + (100.0 * (widget.text.length % 5)),
          left: animValue * 200,
          child: Opacity(
            opacity: opacity,
            child: Text(widget.text, style: AppTypography.p.copyWith(fontSize: 16)),
          ),
        );
      },
    );
  }
}

class Workout4Drill1LockInScreen extends StatelessWidget {
  final VoidCallback onNext;
  const Workout4Drill1LockInScreen({required this.onNext, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: () {}, // Lock back
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('You did not stop the thought.', style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('You stopped feeding it.', style: AppTypography.h2.copyWith(fontSize: 28, color: AppColors.accent), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4Drill2EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4Drill2EntryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Break Urgency', style: AppTypography.h1.copyWith(fontSize: 34)),
          const SizedBox(height: 12),
          Text('Urgency is a feeling.\nNot a command.', style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5))),
        ],
      ),
    );
  }
}

class Workout4Drill2PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout4Drill2PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout4Drill2PlayScreen> createState() => _Workout4Drill2PlayScreenState();
}

class _Workout4Drill2PlayScreenState extends State<Workout4Drill2PlayScreen> {
  double sliderVal = 0;
  bool waiting = false;
  int secondsRemaining = 10;
  Timer? timer;

  void startWait() {
    setState(() => waiting = true);
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) {
        setState(() {
          secondsRemaining--;
          if (secondsRemaining <= 0) {
            t.cancel();
            widget.onComplete();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (waiting) {
      return Scaffold(
        backgroundColor: AppColors.surface,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeInDown(
                child: Text('Wait.', style: AppTypography.h1.copyWith(fontSize: 44)),
              ),
              const SizedBox(height: 20),
              Text('$secondsRemaining',
                  style: AppTypography.h2.copyWith(fontSize: 200, color: AppColors.ink)),
            ],
          ),
        ),
      );
    }
    return Workout4ContentLayout(
      onNext: sliderVal >= 10 ? startWait : () {},
      onBack: () => Navigator.pop(context),
      showNextButton: sliderVal >= 10,
      nextButtonText: 'Set Delay',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('This needs thinking about — now.',
              style: AppTypography.h2.copyWith(fontSize: 26),
              textAlign: TextAlign.center),
          const SizedBox(height: 48),
          Text('Set a delay: ${sliderVal.toInt()} seconds',
              style: AppTypography.columnHeader),
          const SizedBox(height: 12),
          Slider(
            value: sliderVal,
            min: 0,
            max: 10,
            divisions: 10,
            activeColor: AppColors.ink,
            inactiveColor: AppColors.line,
            onChanged: (v) => setState(() => sliderVal = v),
          ),
          const SizedBox(height: 12),
          Text('Slide to 10 to force the wait.',
              style: AppTypography.p
                  .copyWith(fontSize: 12, color: AppColors.ink.withOpacity(0.3))),
        ],
      ),
    );
  }
}

class Workout4Drill2ResultScreen extends StatelessWidget {
  final VoidCallback onNext;
  const Workout4Drill2ResultScreen({required this.onNext, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: () {},
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Urgency made a promise.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('Nothing arrived.', style: AppTypography.h1.copyWith(fontSize: 34), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text('That was pressure without proof.', style: AppTypography.p.copyWith(fontSize: 16), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4Drill2LockInScreen extends StatelessWidget {
  final VoidCallback onNext;
  const Workout4Drill2LockInScreen({required this.onNext, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: () {},
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Urgency is not intelligence.', style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text("It's pressure.", style: AppTypography.h2.copyWith(fontSize: 28, color: AppColors.accent), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4Drill3EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4Drill3EntryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Cut the Loop', style: AppTypography.h1.copyWith(fontSize: 34)),
          const SizedBox(height: 12),
          Text('Overthinking survives by finishing itself.', style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.5))),
          const SizedBox(height: 32),
          Text('This drill trains one thing.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('Leaving thoughts unfinished.', style: AppTypography.h2.copyWith(fontSize: 24), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4Drill3PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout4Drill3PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout4Drill3PlayScreen> createState() => _Workout4Drill3PlayScreenState();
}

class _Workout4Drill3PlayScreenState extends State<Workout4Drill3PlayScreen> {
  String text = '';
  String target = 'What if this means that I should have done something else and now...';
  bool isCut = false;
  Timer? timer;
  bool isWaiting = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() => isWaiting = false);
        _startTyping();
      }
    });
  }

  void _startTyping() {
    int i = 0;
    timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      if (mounted && !isCut) {
        setState(() {
          text += target[i];
          i++;
          if (i >= target.length) t.cancel();
        });
      }
    });
  }

  void cut() {
    setState(() => isCut = true);
    timer?.cancel();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isWaiting ? 'Wait.' : (isCut ? 'Wait.' : 'Do not finish it.'),
                style: AppTypography.columnHeader),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Text(text.isEmpty ? '…' : '$text|',
                  style: AppTypography.h2.copyWith(fontSize: 22)),
            ),
            const SizedBox(height: 64),
            if (!isCut && !isWaiting)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16)),
                onPressed: cut,
                child: const Text('CUT HERE'),
              ),
          ],
        ),
      ),
    );
  }
}

class Workout4Drill3HoldScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout4Drill3HoldScreen({required this.onComplete, super.key});
  @override
  State<Workout4Drill3HoldScreen> createState() => _Workout4Drill3HoldScreenState();
}

class _Workout4Drill3HoldScreenState extends State<Workout4Drill3HoldScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), widget.onComplete);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Leave it unfinished.', style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text('Hold the open loop.', style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.45))),
          ],
        ),
      ),
    );
  }
}

class Workout4Drill3ResultScreen extends StatelessWidget {
  final VoidCallback onNext;
  const Workout4Drill3ResultScreen({required this.onNext, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: () {},
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('The thought did not finish.', style: AppTypography.h2.copyWith(fontSize: 26), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('Nothing happened.', style: AppTypography.h2.copyWith(fontSize: 26, color: AppColors.accent), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text('Completion was never required.', style: AppTypography.p.copyWith(fontSize: 16), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4Drill3LockInScreen extends StatelessWidget {
  final VoidCallback onNext;
  const Workout4Drill3LockInScreen({required this.onNext, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: () {},
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Thoughts don't need endings", style: AppTypography.h2.copyWith(fontSize: 28), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('They need less authority', style: AppTypography.h2.copyWith(fontSize: 28, color: AppColors.accent), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

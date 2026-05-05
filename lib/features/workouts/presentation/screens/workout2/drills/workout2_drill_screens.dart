import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout2_content_layout.dart';

class Workout2D1EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2D1EntryScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Start',
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Watch It Multiply', style: AppTypography.h1.copyWith(fontSize: 34), textAlign: TextAlign.center),
          const SizedBox(height: 14),
          Text('Loops do not grow from new danger.\nThey grow from repeated meaning.', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('Watch what multiplies.', style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.3))),
        ],
      ),
    );
  }
}

class Workout2D1PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout2D1PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout2D1PlayScreen> createState() => _Workout2D1PlayScreenState();
}

class _Workout2D1PlayScreenState extends State<Workout2D1PlayScreen> {
  int _level = 0;
  @override
  void initState() {
    super.initState();
    _run();
  }

  void _run() async {
    for (int i = 1; i <= 4; i++) {
      await Future.delayed(const Duration(milliseconds: 1200));
      if (!mounted) return;
      setState(() => _level = i);
    }
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final count = _level == 0 ? 1 : (1 << (_level - 1));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Sensation', style: AppTypography.h1.copyWith(fontSize: 30, color: AppColors.ink.withOpacity(0.2))),
              const SizedBox(height: 18),
              for (int i = 0; i < count; i++)
                Text('What if this is bad?', style: AppTypography.h2.copyWith(fontSize: 18 + (_level * 1.2), color: AppColors.accent)),
              if (_level >= 4) ...[
                const SizedBox(height: 14),
                Text('Do nothing.', style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.3))),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Workout2D2EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2D2EntryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Start',
      showHome: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Do Not Answer the Second Alarm', style: AppTypography.h1.copyWith(fontSize: 32), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('The loop grows when the system answers its own echo.', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout2D2PlayIntroScreen extends StatefulWidget {
  final VoidCallback onNext;
  const Workout2D2PlayIntroScreen({required this.onNext, super.key});
  @override
  State<Workout2D2PlayIntroScreen> createState() => _Workout2D2PlayIntroScreenState();
}

class _Workout2D2PlayIntroScreenState extends State<Workout2D2PlayIntroScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) widget.onNext();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'A sensation appears.\nThen the system adds a second alarm.\n\nYou will see the echo.\nDo not answer it.',
            style: AppTypography.h2.copyWith(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class Workout2D2PlayLoopScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout2D2PlayLoopScreen({required this.onComplete, super.key});
  @override
  State<Workout2D2PlayLoopScreen> createState() => _Workout2D2PlayLoopScreenState();
}

class _Workout2D2PlayLoopScreenState extends State<Workout2D2PlayLoopScreen> {
  int _round = 1;
  bool _echoShown = false;
  bool _locked = false;
  String? _micro;
  double _stroke = 2;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startRound();
  }

  void _startRound() {
    _echoShown = false;
    _locked = false;
    _micro = null;
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() => _echoShown = true);
      _timer = Timer(const Duration(milliseconds: 5000), () {
        if (!mounted || _locked) return;
        setState(() => _stroke += 1.5);
        _nextRound();
      });
    });
  }

  void _choose(bool answered) {
    if (!_echoShown || _locked) return;
    setState(() {
      _locked = true;
      _micro = answered ? 'That was the second alarm.' : null;
      _stroke = answered ? (_stroke - 1).clamp(1, 10) : _stroke;
    });
    Future.delayed(const Duration(milliseconds: 1500), _nextRound);
  }

  void _nextRound() {
    if (!mounted) return;
    if (_round >= 3) {
      widget.onComplete();
      return;
    }
    setState(() => _round += 1);
    _startRound();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2238),
      body: Stack(
        children: [
          Positioned(top: 80, left: 0, right: 0, child: Text('Round $_round / 3', style: AppTypography.columnHeader.copyWith(color: Colors.white.withOpacity(0.35)), textAlign: TextAlign.center)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.25), width: _stroke)),
                  child: Center(child: Text('Mind ↔ Body', style: AppTypography.columnHeader.copyWith(color: Colors.white.withOpacity(0.45), fontSize: 9))),
                ),
                const SizedBox(height: 24),
                Text('Sensation', style: AppTypography.h2.copyWith(color: Colors.white)),
                if (_echoShown) ...[
                  const SizedBox(height: 10),
                  Text('What if this gets worse?', style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 24)),
                  Text('Answer it.', style: AppTypography.columnHeader.copyWith(color: Colors.white.withOpacity(0.4), fontSize: 8)),
                ],
              ],
            ),
          ),
          if (_micro != null) Positioned(bottom: 140, left: 0, right: 0, child: Text(_micro!, style: AppTypography.p.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 14), textAlign: TextAlign.center)),
          Positioned(
            bottom: 64,
            left: 24,
            right: 24,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6557FF), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99))),
                    onPressed: _locked ? null : () => _choose(true),
                    child: Text('ECHO', style: AppTypography.btnText.copyWith(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white.withOpacity(0.3)), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99))),
                    onPressed: _locked ? null : () => _choose(false),
                    child: Text('Not Now', style: AppTypography.btnText.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Workout2D3EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout2D3EntryScreen({required this.onNext, required this.onBack, super.key});
  @override
  Widget build(BuildContext context) {
    return Workout2ContentLayout(
      onNext: onNext,
      onBack: onBack,
      showHome: false,
      nextButtonText: '▶ Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Interrupt the Structure', style: AppTypography.h1.copyWith(fontSize: 34), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('The loop has a predictable sequence.\nBreak it at the growth point.', style: AppTypography.p.copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout2D3PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout2D3PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout2D3PlayScreen> createState() => _Workout2D3PlayScreenState();
}

class _Workout2D3PlayScreenState extends State<Workout2D3PlayScreen> {
  final stages = const ['Sensation', 'Meaning', 'Body Tension', 'Fear of the Sensation', 'Escalation'];
  int? selected;
  String? micro;
  bool locked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Tap the stage where the loop grows.', style: AppTypography.columnHeader.copyWith(fontSize: 9, color: AppColors.ink.withOpacity(0.35))),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: stages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    return GestureDetector(
                      onTap: locked
                          ? null
                          : () {
                              if (i == 3) {
                                setState(() {
                                  selected = i;
                                  locked = true;
                                  micro = 'This is where the loop grows.\nFear of sensation tells the system: this is urgent.\nInterrupt here, and escalation cannot multiply.';
                                });
                              } else {
                                setState(() {
                                  selected = i;
                                  micro = i == 0
                                      ? 'This begins the cycle — but doesn’t grow it.'
                                      : i == 1
                                          ? 'Meaning activates the body — but isn’t the growth point.'
                                          : i == 2
                                              ? 'The body reacts — but tension alone isn’t escalation.'
                                              : 'Escalation is the result — not the cause.';
                                });
                              }
                            },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: selected == i ? AppColors.accent.withOpacity(i == 3 ? 0.9 : 0.07) : Colors.white,
                          border: Border.all(color: AppColors.line.withOpacity(0.6)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          stages[i],
                          style: AppTypography.p.copyWith(
                            fontSize: selected == i && i == 3 ? 17 : 15,
                            color: selected == i && i == 3 ? Colors.white : AppColors.ink.withOpacity(0.7),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (micro != null) ...[
                Text(micro!, style: AppTypography.p.copyWith(fontSize: 13, color: AppColors.ink.withOpacity(0.45)), textAlign: TextAlign.center),
                const SizedBox(height: 14),
              ],
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)), padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                onPressed: locked ? widget.onComplete : null,
                child: Text('▶ Continue', style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


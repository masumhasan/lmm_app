import 'dart:async';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import '../widgets/workout4_content_layout.dart';

// ─────────────────────────────────────────────
//  Entry
// ─────────────────────────────────────────────

class Workout4SkillRepsEntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onSkip;
  const Workout4SkillRepsEntryScreen(
      {required this.onNext, required this.onBack, required this.onSkip, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Start Skill Reps',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeIn(
            child: Text('Train Attention Under Noise',
                style: AppTypography.h1.copyWith(fontSize: 32),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 14),
          FadeIn(
            delay: const Duration(milliseconds: 500),
            child: Text(
              'These games reveal how overthinking works — and how it loses control.',
              style: AppTypography.p
                  .copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.5)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          FadeIn(
            delay: const Duration(milliseconds: 900),
            child: GestureDetector(
              onTap: onSkip,
              child: Text('Skip',
                  style: AppTypography.columnHeader.copyWith(
                    fontSize: 10,
                    color: AppColors.ink.withOpacity(0.3),
                    decoration: TextDecoration.underline,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SR1 — Noise or Signal?
// ─────────────────────────────────────────────

class Workout4SR1IntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4SR1IntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Noise or Signal?',
              style: AppTypography.h1.copyWith(fontSize: 34),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('Overthinking sounds important.\nSignal is quiet.',
              style: AppTypography.p
                  .copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.5)),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text('Tap what each thought actually is.',
              style: AppTypography.p.copyWith(fontSize: 14),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _SR1Card {
  final String text;
  final bool isNoise;
  const _SR1Card(this.text, this.isNoise);
}

class Workout4SR1PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout4SR1PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout4SR1PlayScreen> createState() => _Workout4SR1PlayScreenState();
}

class _Workout4SR1PlayScreenState extends State<Workout4SR1PlayScreen>
    with SingleTickerProviderStateMixin {
  static const _cards = [
    _SR1Card('What if this goes wrong?', true),
    _SR1Card('I notice my jaw is tight.', false),
    _SR1Card('I should think this through again.', true),
    _SR1Card('My mind feels busy right now.', false),
    _SR1Card("If I don't solve this now, something bad will happen.", true),
    _SR1Card('There is pressure behind my eyes.', false),
  ];

  late AnimationController _timerCtrl;
  int _idx = 0;
  String? _feedback;
  bool _responding = false;

  @override
  void initState() {
    super.initState();
    _timerCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _timerCtrl.addStatusListener((s) {
      if (s == AnimationStatus.completed && !_responding) {
        _respond('Default is feeding.');
      }
    });
    _timerCtrl.forward();
  }

  void _tap(bool isNoise) {
    if (_responding) return;
    final correct = _cards[_idx].isNoise;
    _respond(isNoise == correct ? 'Good separation.' : 'Noise sounded like signal.');
  }

  void _respond(String fb) {
    if (_responding) return;
    _responding = true;
    _timerCtrl.stop();
    setState(() => _feedback = fb);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      _timerCtrl.reset();
      setState(() {
        _feedback = null;
        _responding = false;
        _idx++;
      });
      if (_idx >= _cards.length) {
        widget.onComplete();
      } else {
        _timerCtrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _timerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_idx >= _cards.length) return const SizedBox.shrink();
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Text('${_idx + 1} / ${_cards.length}',
                  style: AppTypography.columnHeader.copyWith(
                      fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
              const SizedBox(height: 8),
              AnimatedBuilder(
                animation: _timerCtrl,
                builder: (_, __) => LinearProgressIndicator(
                  value: 1 - _timerCtrl.value,
                  minHeight: 2,
                  backgroundColor: AppColors.line.withOpacity(0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.accent.withOpacity(0.45)),
                ),
              ),
              const Spacer(),
              Text(_cards[_idx].text,
                  style: AppTypography.h2.copyWith(fontSize: 26),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _feedback != null ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Text(_feedback ?? '',
                    style: AppTypography.columnHeader.copyWith(
                        fontSize: 10,
                        color: AppColors.ink.withOpacity(0.4),
                        letterSpacing: 1.5)),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ink.withOpacity(0.07),
                        foregroundColor: AppColors.ink,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => _tap(true),
                      child: Text('Noise',
                          style: AppTypography.btnText
                              .copyWith(color: AppColors.ink)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => _tap(false),
                      child: Text('Signal',
                          style: AppTypography.btnText
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class Workout4SR1InsightScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4SR1InsightScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInDown(
            child: Text('Noise pushes.',
                style: AppTypography.h2.copyWith(fontSize: 28),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 10),
          FadeInDown(
            delay: const Duration(milliseconds: 500),
            child: Text('Signal reports.',
                style: AppTypography.h2.copyWith(fontSize: 28),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 20),
          FadeInDown(
            delay: const Duration(milliseconds: 1000),
            child: Text('Overthinking begins when noise is obeyed.',
                style: AppTypography.p.copyWith(
                    fontSize: 16, color: AppColors.ink.withOpacity(0.55)),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SR2 — Interrupt Without Solving
// ─────────────────────────────────────────────

class Workout4SR2IntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4SR2IntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Begin',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Interrupt Without Solving',
              style: AppTypography.h1.copyWith(fontSize: 32),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('Overthinking weakens when it is not answered.',
              style: AppTypography.p
                  .copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.5)),
              textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text('Tap anywhere when the mind feels loud.',
              style: AppTypography.p.copyWith(fontSize: 14),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4SR2PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout4SR2PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout4SR2PlayScreen> createState() => _Workout4SR2PlayScreenState();
}

class _Workout4SR2PlayScreenState extends State<Workout4SR2PlayScreen> {
  static const _words = ['Pause', 'Seen', 'Enough', 'Not Now'];
  int _count = 0;
  bool _collapsed = false;
  String? _word;
  Timer? _resumeTimer;

  void _interrupt() {
    if (_collapsed) return;
    final word = _words[_count % _words.length];
    setState(() {
      _collapsed = true;
      _word = word;
      _count++;
    });
    if (_count >= 4) {
      Future.delayed(const Duration(milliseconds: 900), widget.onComplete);
      return;
    }
    _resumeTimer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() { _collapsed = false; _word = null; });
    });
  }

  @override
  void dispose() {
    _resumeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _interrupt,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Stack(
          children: [
            if (!_collapsed)
              for (int i = 0; i < 22; i++) _NoiseParticle(index: i),
            Center(
              child: _collapsed && _word != null
                  ? FadeIn(
                      duration: const Duration(milliseconds: 200),
                      child: Text(_word!,
                          style: AppTypography.h1.copyWith(
                              fontSize: 44,
                              color: AppColors.ink.withOpacity(0.13)),
                          textAlign: TextAlign.center),
                    )
                  : !_collapsed
                      ? Text('Tap to interrupt.',
                          style: AppTypography.columnHeader.copyWith(
                              fontSize: 10,
                              color: AppColors.ink.withOpacity(0.22),
                              letterSpacing: 2))
                      : const SizedBox.shrink(),
            ),
            Positioned(
              bottom: 64,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < _count
                          ? AppColors.accent
                          : AppColors.ink.withOpacity(0.1),
                    ),
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

class _NoiseParticle extends StatefulWidget {
  final int index;
  const _NoiseParticle({required this.index});
  @override
  State<_NoiseParticle> createState() => _NoiseParticleState();
}

class _NoiseParticleState extends State<_NoiseParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late double _baseX, _baseY, _radius, _amplitude;

  @override
  void initState() {
    super.initState();
    final r = Random(widget.index * 137 + 31);
    _baseX = r.nextDouble() * 0.85 + 0.07;
    _baseY = r.nextDouble() * 0.70 + 0.15;
    _radius = r.nextDouble() * 3 + 1.5;
    _amplitude = r.nextDouble() * 18 + 6;
    final speed = r.nextInt(1800) + 1200;
    _ctrl = AnimationController(
        vsync: this, duration: Duration(milliseconds: speed))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final t = _ctrl.value;
        return Positioned(
          left: size.width * _baseX + sin(t * pi) * _amplitude,
          top: size.height * _baseY + cos(t * pi * 1.3) * _amplitude * 0.6,
          child: Container(
            width: _radius * 2,
            height: _radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ink.withOpacity(0.06 + t * 0.06),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
//  SR3 — Step Back
// ─────────────────────────────────────────────

class Workout4SR3IntroScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Workout4SR3IntroScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return Workout4ContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '  Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Step Back',
              style: AppTypography.h1.copyWith(fontSize: 34),
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text("You don't argue with thoughts — you change position.",
              style: AppTypography.p
                  .copyWith(fontSize: 15, color: AppColors.ink.withOpacity(0.5)),
              textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text("You'll see a thought appear.\nYour job is not to judge it — only to step back.",
              style: AppTypography.p.copyWith(fontSize: 14),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Workout4SR3PlayScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const Workout4SR3PlayScreen({required this.onComplete, super.key});
  @override
  State<Workout4SR3PlayScreen> createState() => _Workout4SR3PlayScreenState();
}

class _Workout4SR3PlayScreenState extends State<Workout4SR3PlayScreen>
    with TickerProviderStateMixin {
  static const _thoughts = [
    'You need to figure this out right now.',
    'This could turn into a problem.',
    'You should replay what you said.',
    'What if this gets worse?',
    "You can't ignore this.",
  ];
  static const _responses = [
    'Distance created.',
    'Thought observed.',
    'Not engaged.',
    'No action taken.',
  ];

  int _idx = 0;
  bool _showResponse = false;
  String _responseText = '';
  bool _dragging = false;
  double _dragDy = 0.0;

  // approach: 1.0→1.12 over 5s after 3s idle
  late AnimationController _approachCtrl;
  // dismiss: card flies up+shrinks+fades over 400ms
  late AnimationController _dismissCtrl;
  // enter: new card scales/fades in over 350ms
  late AnimationController _enterCtrl;

  Timer? _idleTimer;
  final _rand = Random();

  @override
  void initState() {
    super.initState();
    _approachCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 5));
    _dismissCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _enterCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350))
      ..forward();
    _scheduleApproach();
  }

  void _scheduleApproach() {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && !_dragging) _approachCtrl.forward();
    });
  }

  void _cancelApproach() {
    _idleTimer?.cancel();
    _approachCtrl.stop();
    _approachCtrl.reset();
  }

  void _onDragStart(DragStartDetails _) {
    _cancelApproach();
    setState(() {
      _dragging = true;
      _dragDy = 0.0;
    });
  }

  void _onDragUpdate(DragUpdateDetails d) =>
      setState(() => _dragDy += d.delta.dy);

  void _onDragEnd(DragEndDetails d) {
    final vel = d.primaryVelocity ?? 0;
    if (vel < -200 || _dragDy < -60) {
      setState(() => _dragging = false);
      _startDismiss();
    } else {
      setState(() {
        _dragging = false;
        _dragDy = 0.0;
      });
      _scheduleApproach();
    }
  }

  void _startDismiss() {
    _dismissCtrl.forward().then((_) {
      if (!mounted) return;
      setState(() {
        _showResponse = true;
        _responseText = _responses[_rand.nextInt(_responses.length)];
      });
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        _dismissCtrl.reset();
        setState(() {
          _showResponse = false;
          _dragDy = 0.0;
          _idx++;
        });
        if (_idx >= _thoughts.length) {
          widget.onComplete();
        } else {
          _enterCtrl.reset();
          _enterCtrl.forward();
          _scheduleApproach();
        }
      });
    });
  }

  double get _cardScale {
    if (!_approachCtrl.isAnimating && _approachCtrl.value == 0) return 1.0;
    final approach = 1.0 + _approachCtrl.value * 0.12;
    if (_dismissCtrl.value > 0) {
      return (approach * (1.0 - _dismissCtrl.value * 0.85)).clamp(0.01, 2.0);
    }
    if (_dragging && _dragDy < 0) {
      final p = (-_dragDy / 200).clamp(0.0, 1.0);
      return approach * (1.0 - p * 0.65);
    }
    return approach;
  }

  double get _cardOpacity {
    if (_dismissCtrl.value > 0) {
      return (1.0 - _dismissCtrl.value * 1.3).clamp(0.0, 1.0);
    }
    if (_dragging && _dragDy < 0) {
      return (1.0 - (-_dragDy / 200).clamp(0.0, 1.0) * 0.75).clamp(0.0, 1.0);
    }
    return 1.0;
  }

  double get _cardDy {
    if (_dismissCtrl.value > 0) return -150 * _dismissCtrl.value;
    if (_dragging) return _dragDy.clamp(-300.0, 80.0);
    return 0.0;
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _approachCtrl.dispose();
    _dismissCtrl.dispose();
    _enterCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_idx >= _thoughts.length) return const SizedBox.shrink();
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: AnimatedBuilder(
        animation:
            Listenable.merge([_approachCtrl, _dismissCtrl, _enterCtrl]),
        builder: (context, _) {
          final enterFactor = 0.88 + _enterCtrl.value * 0.12;
          return Stack(
            children: [
              Positioned(
                top: 80,
                left: 24,
                right: 24,
                child: Text(
                  'When you notice the thought pulling you in — swipe up.',
                  style: AppTypography.columnHeader.copyWith(
                      fontSize: 9,
                      color: AppColors.ink.withOpacity(0.28),
                      letterSpacing: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: GestureDetector(
                  onVerticalDragStart: _onDragStart,
                  onVerticalDragUpdate: _onDragUpdate,
                  onVerticalDragEnd: _onDragEnd,
                  child: Opacity(
                    opacity: (_cardOpacity * _enterCtrl.value).clamp(0.0, 1.0),
                    child: Transform.translate(
                      offset: Offset(0, _cardDy),
                      child: Transform.scale(
                        scale: _cardScale * enterFactor,
                        child: Container(
                          margin:
                              const EdgeInsets.symmetric(horizontal: 36),
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                    0.05 + (_approachCtrl.isAnimating || _approachCtrl.value != 0 ? _approachCtrl.value : 0) * 0.04),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Text(_thoughts[_idx],
                              style: AppTypography.h2.copyWith(fontSize: 22),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showResponse)
                Center(
                  child: FadeIn(
                    duration: const Duration(milliseconds: 200),
                    child: Text(_responseText,
                        style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            color: AppColors.ink.withOpacity(0.3),
                            letterSpacing: 2),
                        textAlign: TextAlign.center),
                  ),
                ),
              Positioned(
                bottom: 64,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _thoughts.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _idx ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: i < _idx
                            ? AppColors.accent
                            : i == _idx
                                ? AppColors.ink.withOpacity(0.25)
                                : AppColors.ink.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Skill Reps Complete
// ─────────────────────────────────────────────

class Workout4SkillRepsCompleteScreen extends StatefulWidget {
  final VoidCallback onHub;
  final VoidCallback onHome;
  const Workout4SkillRepsCompleteScreen(
      {required this.onHub, required this.onHome, super.key});

  @override
  State<Workout4SkillRepsCompleteScreen> createState() => _Workout4SkillRepsCompleteScreenState();
}

class _Workout4SkillRepsCompleteScreenState extends State<Workout4SkillRepsCompleteScreen> {
  int _phase = 0;

  @override
  void initState() {
    super.initState();
    _revealPhases();
  }

  void _revealPhases() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _phase = 1);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _phase = 2);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _phase = 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: _LinearSync4.subtleRadial(AppColors.accent.withOpacity(0.03)),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: Column(
                      children: [
                        Text(
                          'WORKOUT 4',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            letterSpacing: 4.0,
                            color: AppColors.ink.withOpacity(0.25),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'You Stepped Out\nof the Noise',
                          style: AppTypography.h1.copyWith(
                            fontSize: 38,
                            fontStyle: FontStyle.italic,
                            height: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Phase 1 — Insight
                  AnimatedOpacity(
                    opacity: _phase >= 1 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: Column(
                      children: [
                        Text(
                          "“Overthinking didn't stop because you solved it.\nIt stopped because you stopped obeying it.”",
                          style: AppTypography.p.copyWith(
                            fontSize: 15,
                            color: AppColors.ink.withOpacity(0.4),
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'This is a learning skill — not a fix.',
                          style: AppTypography.columnHeader.copyWith(
                              fontSize: 9, color: AppColors.ink.withOpacity(0.3)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 70),
                  
                  // Phase 2 — Actions
                  if (_phase >= 2) ...[
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: _CompletionAction4(
                        label: 'EXPLORE WORKOUT 4 LIBRARY',
                        icon: LucideIcons.bookOpen,
                        isPrimary: true,
                        onTap: () => context.push('/hub/library/workout4'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      child: _CompletionAction4(
                        label: 'EXPLORE TOOLS HUB',
                        icon: LucideIcons.layoutGrid,
                        onTap: widget.onHub,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: _CompletionAction4(
                        label: 'RETURN HOME',
                        icon: LucideIcons.home,
                        onTap: widget.onHome,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletionAction4 extends StatelessWidget {
  final String label;
  final String? subLabel;
  final IconData icon;
  final bool isPrimary;
  final bool isBadge;
  final VoidCallback onTap;

  const _CompletionAction4({
    required this.label,
    this.subLabel,
    required this.icon,
    this.isPrimary = false,
    this.isBadge = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: AppTypography.columnHeader.copyWith(
                          fontSize: 11,
                          letterSpacing: 1.2,
                          color: isPrimary ? Colors.white : AppColors.ink,
                        ),
                      ),
                      if (isBadge) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.ink.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'LOCKED',
                            style: AppTypography.columnHeader.copyWith(
                              fontSize: 7,
                              color: AppColors.ink.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (subLabel != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subLabel!,
                      style: AppTypography.p.copyWith(
                        fontSize: 13,
                        color: isPrimary 
                            ? Colors.white.withOpacity(0.7) 
                            : AppColors.ink.withOpacity(0.4),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              icon,
              size: 18,
              color: isPrimary 
                  ? Colors.white.withOpacity(0.6) 
                  : AppColors.ink.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinearSync4 {
  static RadialGradient subtleRadial(Color color) {
    return RadialGradient(
      center: const Alignment(0, -0.2),
      radius: 1.2,
      colors: [color, Colors.transparent],
    );
  }
}

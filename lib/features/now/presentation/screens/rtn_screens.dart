import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import '../widgets/rtn_layout.dart';

class RTN01EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const RTN01EntryScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return RTNLayout(
      onBack: onBack,
      onNext: onNext,
      nextButtonText: '▶ Begin',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Return To Now',
            style: AppTypography.h1.copyWith(fontSize: 34),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'This does not change how you feel.\nIt changes where attention is placed.',
            style: AppTypography.p.copyWith(
              color: AppColors.ink.withOpacity(0.5),
              fontSize: 16,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RTN02VisualScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const RTN02VisualScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<RTN02VisualScreen> createState() => _RTN02VisualScreenState();
}

class _RTN02VisualScreenState extends State<RTN02VisualScreen> {
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => showButton = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RTNLayout(
      onBack: widget.onBack,
      onNext: widget.onNext,
      showNextButton: showButton,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Look',
            style: AppTypography.h1.copyWith(fontSize: 48, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'Name 3 visible objects.\nNo story. Just label.',
            style: AppTypography.p.copyWith(fontSize: 20, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Column(
            children: [
              _MicroLine(text: '“Chair.”'),
              _MicroLine(text: '“Light.”'),
              _MicroLine(text: '“Wall.”'),
            ],
          ),
        ],
      ),
    );
  }
}

class RTN03AudioScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const RTN03AudioScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<RTN03AudioScreen> createState() => _RTN03AudioScreenState();
}

class _RTN03AudioScreenState extends State<RTN03AudioScreen> {
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => showButton = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RTNLayout(
      onBack: widget.onBack,
      onNext: widget.onNext,
      showNextButton: showButton,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Listen',
            style: AppTypography.h1.copyWith(fontSize: 48, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'Notice 2 sounds.\nNear or distant.\nNo interpretation.',
            style: AppTypography.p.copyWith(fontSize: 20, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RTN04PhysicalScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const RTN04PhysicalScreen({required this.onNext, required this.onBack, super.key});

  @override
  State<RTN04PhysicalScreen> createState() => _RTN04PhysicalScreenState();
}

class _RTN04PhysicalScreenState extends State<RTN04PhysicalScreen> {
  bool showButton = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => showButton = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RTNLayout(
      onBack: widget.onBack,
      onNext: widget.onNext,
      showNextButton: showButton,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Contact',
            style: AppTypography.h1.copyWith(fontSize: 48, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Text(
            'Notice 1 physical point of contact.',
            style: AppTypography.p.copyWith(fontSize: 20, height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Column(
            children: [
              _MicroLine(text: 'Feet on floor.'),
              _MicroLine(text: 'Back on chair.'),
              _MicroLine(text: 'Hands touching.'),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'No adjustment.\nJust observe.',
            style: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.4), fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RTN05ExitScreen extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback? onBackToWorkout;

  const RTN05ExitScreen({required this.onHome, this.onBackToWorkout, super.key});

  @override
  Widget build(BuildContext context) {
    return RTNLayout(
      onBack: onHome,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Attention Repositioned',
            style: AppTypography.h1.copyWith(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            'Thoughts may still be present.\nSensations may still be present.\nAttention is now here.',
            style: AppTypography.p.copyWith(
              color: AppColors.ink.withOpacity(0.5),
              fontSize: 16,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
          SizedBox(
            width: 250,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: onHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981), // Green
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    elevation: 0,
                  ),
                  child: const Text('Return to Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                if (onBackToWorkout != null) ...[
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: onBackToWorkout,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.ink.withOpacity(0.1)),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                    child: Text('Back to Workout', style: TextStyle(color: AppColors.ink.withOpacity(0.5))),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MicroLine extends StatelessWidget {
  final String text;
  const _MicroLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: AppTypography.columnHeader.copyWith(
          color: AppColors.ink.withOpacity(0.15),
          fontSize: 14,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

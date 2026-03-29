import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/workout_content_layout.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class Drill3EntryScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Drill3EntryScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      nextButtonText: '▶ Start',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),
          Text(
            'Completion Tolerance Open Loop Test',
            style: AppTypography.h1.copyWith(fontSize: 34, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'You are training discomfort tolerance.',
            style: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class Drill3IncompleteScreen extends StatefulWidget {
  final VoidCallback onNext;
  const Drill3IncompleteScreen({required this.onNext, super.key});

  @override
  State<Drill3IncompleteScreen> createState() => _Drill3IncompleteScreenState();
}

class _Drill3IncompleteScreenState extends State<Drill3IncompleteScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isHolding = false;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _onTextChanged(String value) {
    if (isHolding || isCompleted) return;

    final upperValue = value.toUpperCase();
    if (upperValue == 'CONTROL') {
      _triggerAutoDelete();
    }
  }

  void _triggerAutoDelete() async {
    setState(() => isHolding = true);
    
    // Auto-delete last letter within 0.15s
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;
    
    _controller.text = 'CONTRO';
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
    
    // Hold 5 seconds
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted) return;
    
    setState(() {
      isHolding = false;
      isCompleted = true;
    });
    
    _focusNode.unfocus();
    // Navigate automatically to release screen
    widget.onNext();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Header Instruction
          Positioned(
            top: 100,
            left: 48,
            right: 48,
            child: Text(
              'DO NOT FINISH THE WORD.',
              style: AppTypography.columnHeader.copyWith(
                fontSize: 8,
                letterSpacing: 3.5,
                color: AppColors.ink.withOpacity(0.15),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Type the word “CONTROL”',
                  style: AppTypography.h2.copyWith(fontSize: 22, color: AppColors.ink.withOpacity(0.4)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Container(
                  width: 280,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.ink.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onChanged: _onTextChanged,
                    enabled: !isHolding && !isCompleted,
                    textAlign: TextAlign.center,
                    style: AppTypography.mono.copyWith(fontSize: 28, letterSpacing: 4.0),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                      UpperCaseTextFormatter(),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    maxLength: 7,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                ),
                if (isHolding)
                  FadeIn(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        'THE URGE TO COMPLETE IS INTENTIONAL.',
                        style: AppTypography.columnHeader.copyWith(
                          fontSize: 8,
                          color: AppColors.ink.withOpacity(0.2),
                          letterSpacing: 1.5,
                        ),
                      ),
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

class Drill3ReleaseScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  const Drill3ReleaseScreen({required this.onNext, required this.onBack, super.key});

  @override
  Widget build(BuildContext context) {
    return WorkoutContentLayout(
      onNext: onNext,
      onBack: onBack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInDown(
            child: Text(
              'Your system demanded closure.',
              style: AppTypography.h2.copyWith(fontSize: 24, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FadeInDown(
            delay: const Duration(milliseconds: 800),
            child: Text(
              'You held the loop open.',
              style: AppTypography.h2.copyWith(fontSize: 24, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          FadeIn(
            delay: const Duration(milliseconds: 1600),
            child: Text(
              'That builds tolerance.',
              style: AppTypography.p.copyWith(fontSize: 14, color: AppColors.ink.withOpacity(0.5)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

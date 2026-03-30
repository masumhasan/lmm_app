import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:animate_do/animate_do.dart';

class JournalScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final VoidCallback onBack;

  const JournalScreen({
    required this.onNext,
    required this.onSkip,
    required this.onBack,
    super.key,
  });

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _controller = TextEditingController();
  final Set<String> _selectedTags = {};
  final List<String> _tags = ['Work', 'Family', 'Self', 'Body', 'Social', 'Unknown'];

  bool _isListening = false;
  Timer? _typeTimer;

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  void _startListening() {
    if (_isListening) {
      _stopListening();
      return;
    }

    setState(() {
      _isListening = true;
    });

    // Simulate STT auto-typing
    const simulatedText = " I noticed my attention shifting towards a future worry about tomorrow's presentation, but then I used the grounding exercise to return to the present moment.";
    int charIndex = 0;
    
    _typeTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (charIndex < simulatedText.length) {
        if (mounted) {
          setState(() {
            _controller.text += simulatedText[charIndex];
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          });
        }
        charIndex++;
      } else {
        _stopListening();
      }
    });
  }

  void _stopListening() {
    _typeTimer?.cancel();
    setState(() {
      _isListening = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _typeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onBack,
                  child: Row(
                    children: [
                      Icon(LucideIcons.arrowLeft, size: 14, color: AppColors.ink.withOpacity(0.3)),
                      const SizedBox(width: 8),
                      Text('BACK', style: AppTypography.columnHeader.copyWith(fontSize: 10, color: AppColors.ink.withOpacity(0.3))),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    'Training Log — Workout 0',
                    style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.2)),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),
            
            // Prompts
            FadeIn(
              child: Text(
                'Where did your attention move automatically today?',
                style: AppTypography.h2.copyWith(fontSize: 24, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            FadeIn(
              delay: const Duration(milliseconds: 600),
              child: Text(
                'Which muscle could have been applied?',
                style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 64),

            // Text Field with Integrated Mic
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Share your reflection...',
                    hintStyle: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.2)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.fromLTRB(20, 20, 64, 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.line.withOpacity(0.2)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors.line.withOpacity(0.2)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: GestureDetector(
                    onTap: _startListening,
                    child: _MicButton(isListening: _isListening),
                  ),
                ),
              ],
            ),
            
            if (_isListening)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: FadeIn(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PulseDot(),
                      const SizedBox(width: 8),
                      Text(
                        'System Listening...',
                        style: AppTypography.columnHeader.copyWith(
                          fontSize: 10,
                          color: const Color(0xFF10B981),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 48),

            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _tags.map((tag) => _TagChip(
                tag: tag, 
                isSelected: _selectedTags.contains(tag),
                onTap: () => _toggleTag(tag),
              )).toList(),
            ),
            const SizedBox(height: 64),

            // Buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              ),
              onPressed: widget.onNext,
              child: Text('Save Reflection', style: AppTypography.btnText.copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: widget.onSkip,
              child: Text(
                'Skip for Now',
                style: AppTypography.columnHeader.copyWith(
                  fontSize: 10,
                  color: AppColors.ink.withOpacity(0.3),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MicButton extends StatelessWidget {
  final bool isListening;
  const _MicButton({required this.isListening});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isListening ? const Color(0xFF10B981).withOpacity(0.1) : AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isListening ? const Color(0xFF10B981) : AppColors.line.withOpacity(0.2),
        ),
      ),
      child: Icon(
        LucideIcons.mic,
        size: 20, 
        color: isListening ? const Color(0xFF10B981) : AppColors.ink.withOpacity(0.4),
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFF10B981),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String tag;
  final bool isSelected;
  final VoidCallback onTap;
  const _TagChip({required this.tag, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.line.withOpacity(0.2),
          ),
        ),
        child: Text(
          tag.toUpperCase(),
          style: AppTypography.columnHeader.copyWith(
            fontSize: 8,
            color: isSelected ? AppColors.accent : AppColors.ink.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}

class JournalConfirmScreen extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onHome;

  const JournalConfirmScreen({
    required this.onContinue,
    required this.onHome,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeIn(
                child: Text(
                  'Training log updated.',
                  style: AppTypography.h2.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              FadeIn(
                delay: const Duration(milliseconds: 600),
                child: Text(
                  'Repetition builds strength.',
                  style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
                  textAlign: TextAlign.center,
                ),
              ),
              FadeIn(
                delay: const Duration(milliseconds: 1000),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                      ),
                      onPressed: onContinue,
                      child: Text('Continue to Skill Reps', style: AppTypography.btnText.copyWith(color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        side: BorderSide(color: AppColors.ink.withOpacity(0.1)),
                      ),
                      onPressed: onHome,
                      child: Text('Return Home', style: AppTypography.btnText.copyWith(color: AppColors.ink.withOpacity(0.5))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

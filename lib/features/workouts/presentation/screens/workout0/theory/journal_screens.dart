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

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
                Text(
                  'Training Log — Workout 0',
                  style: AppTypography.columnHeader.copyWith(fontSize: 8, color: AppColors.ink.withOpacity(0.2)),
                ),
              ],
            ),
            const SizedBox(height: 64),
            
            // Prompts
            FadeInUp(
              child: Text(
                'Where did your attention move automatically today?',
                style: AppTypography.h2.copyWith(fontSize: 24, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: Text(
                'Which muscle could have been applied?',
                style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 64),

            // Input Options
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _InputOption(icon: LucideIcons.edit3, label: 'Type'),
                const SizedBox(width: 16),
                _InputOption(icon: LucideIcons.mic, label: 'Record'),
                const SizedBox(width: 16),
                _InputOption(icon: LucideIcons.link, label: 'Link'),
              ],
            ),
            const SizedBox(height: 32),

            // Text Field
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Share your reflection...',
                hintStyle: AppTypography.p.copyWith(color: AppColors.ink.withOpacity(0.2)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.line.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.line.withOpacity(0.2)),
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
              child: Text('💾 Save Reflection', style: AppTypography.btnText.copyWith(color: Colors.white)),
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

class _InputOption extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InputOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: AppColors.ink.withOpacity(0.4)),
          const SizedBox(height: 8),
          Text(label.toUpperCase(), style: AppTypography.columnHeader.copyWith(fontSize: 8)),
        ],
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
              FadeInDown(
                child: Text(
                  'Training log updated.',
                  style: AppTypography.h2.copyWith(fontSize: 26, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              FadeInDown(
                delay: const Duration(milliseconds: 600),
                child: Text(
                  'Repetition builds strength.',
                  style: AppTypography.p.copyWith(fontSize: 16, color: AppColors.ink.withOpacity(0.4)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
                onPressed: onContinue,
                child: Text('🟢 Continue to Skill Reps', style: AppTypography.btnText.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  side: BorderSide(color: AppColors.ink.withOpacity(0.1)),
                ),
                onPressed: onHome,
                child: Text('⚪ Return Home', style: AppTypography.btnText.copyWith(color: AppColors.ink.withOpacity(0.5))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'My Profile',
          style: AppTypography.h2.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings, color: Colors.black, size: 20),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            
            // Header Section from Reference
            FadeInDown(
              child: Column(
                children: [
                  // Profile Details
                  Text(
                    'Jhonson King',
                    style: AppTypography.h1.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'jhonking@gmail.com',
                    style: AppTypography.p.copyWith(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Edit Profile Button
                  SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF21A453), // Green from reference
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: AppTypography.btnText.copyWith(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 60),

            // Muscle Dashboard Summary (Numbers) - Integrated requested feature
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.line.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'MUSCLE DENSITY',
                          style: AppTypography.columnHeader.copyWith(
                            fontSize: 10,
                            letterSpacing: 1.5,
                            color: AppColors.ink.withOpacity(0.4),
                          ),
                        ),
                        Icon(LucideIcons.activity, size: 14, color: AppColors.accent.withOpacity(0.5)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _MuscleStat(label: 'ATTENTION', value: '42', color: Color(0xFF6366F1)),
                        _MuscleStat(label: 'URGENCY', value: '18', color: Color(0xFFF59E0B)),
                        _MuscleStat(label: 'STORY', value: '31', color: Color(0xFF10B981)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Divider(color: AppColors.line.withOpacity(0.1)),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => context.push('/hub/muscle-dashboard'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'VIEW FULL DASHBOARD',
                            style: AppTypography.columnHeader.copyWith(
                              fontSize: 9,
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(LucideIcons.chevronRight, size: 10, color: AppColors.accent),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 100),

            // Logout Button (Bottom) from Reference
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Divider(color: Colors.black.withOpacity(0.05)),
                    ListTile(
                      onTap: () {},
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      leading: const Icon(LucideIcons.logOut, color: Color(0xFFE53935), size: 20),
                      title: Text(
                        'Log Out',
                        style: AppTypography.p.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      trailing: Icon(LucideIcons.chevronRight, color: Colors.black.withOpacity(0.2), size: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _MuscleStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MuscleStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.h1.copyWith(fontSize: 28, color: AppColors.ink),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: AppTypography.columnHeader.copyWith(
              fontSize: 8,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

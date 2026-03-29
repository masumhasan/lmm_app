import 'package:flutter/material.dart';
import 'package:lmm_app/core/theme/app_colors.dart';
import 'package:lmm_app/core/theme/app_typography.dart';
import 'package:lmm_app/features/drift/domain/models/drift_tile.dart';

class DriftScreen extends StatelessWidget {
  const DriftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = DriftTile.mockList;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Module: Drift'.toUpperCase(),
              style: AppTypography.columnHeader.copyWith(
                color: AppColors.ink.withOpacity(0.3),
                letterSpacing: 3.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Psychological Mirroring',
              style: AppTypography.h1.copyWith(fontSize: 34),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Center(
              child: Container(
                width: 48,
                height: 1,
                color: AppColors.ink.withOpacity(0.05),
              ),
            ),
            const SizedBox(height: 64),
            ListView.separated(
              itemCount: tiles.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 64),
              itemBuilder: (context, index) {
                final tile = tiles[index];
                return _DriftTileWidget(tile: tile);
              },
            ),
            const SizedBox(height: 120),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 1,
                    height: 96,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.ink.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'End of Analysis Stream'.toUpperCase(),
                    style: AppTypography.columnHeader.copyWith(
                      color: AppColors.ink.withOpacity(0.2),
                      letterSpacing: 4.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DriftTileWidget extends StatelessWidget {
  final DriftTile tile;
  const _DriftTileWidget({required this.tile});

  @override
  Widget build(BuildContext context) {
    if (tile.type == DriftTileType.image) {
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]),
                child: Image.network(
                  tile.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.ink.withOpacity(0.05),
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _RefId(id: tile.id),
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: AppColors.ink.withOpacity(0.05),
                ),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Text(
                    'TEXT_FRAGMENT_${tile.id}'.toUpperCase(),
                    style: AppTypography.columnHeader.copyWith(
                      fontSize: 7,
                      color: AppColors.ink.withOpacity(0.15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    '"${tile.content}"',
                    style: AppTypography.h2.copyWith(
                      fontSize: 26,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _RefId(id: tile.id),
        ],
      );
    }
  }
}

class _RefId extends StatelessWidget {
  final int id;
  const _RefId({required this.id});

  @override
  Widget build(BuildContext context) {
    return Text(
      'REF_ID_00$id // ANALYSIS_PENDING',
      style: AppTypography.columnHeader.copyWith(
        fontSize: 8,
        color: AppColors.ink.withOpacity(0.2),
        letterSpacing: 3.0,
      ),
    );
  }
}

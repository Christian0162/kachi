import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../config/constant/app_colors.dart';
import '../../../../../config/constant/app_spacing.dart';
import '../../../../../config/constant/app_typography.dart';
import '../../../types/memories/memory_summary.dart';
import '../../atoms/common/md_local_photo.dart';
import '../../atoms/common/md_sticker.dart';
import '../../molecules/common/md_poster_card.dart';

/// "1 year ago today" — resurfaces a memory from this date so the app
/// feels like a time capsule, and nudges "do it again". The photo fills the
/// card with the sticker, title and "Relive it" inside it.
class MdOnThisDayCard extends StatelessWidget {
  const MdOnThisDayCard({
    super.key,
    required this.summary,
    required this.today,
    required this.onTap,
  });

  final MemorySummary summary;
  final DateTime today;
  final VoidCallback onTap;

  String get _ago {
    final years = today.year - summary.memory.capturedAt.year;
    return years == 1 ? '1 year ago today' : '$years years ago today';
  }

  @override
  Widget build(BuildContext context) {
    return MdPosterCard(
      onTap: onTap,
      aspectRatio: 16 / 10,
      radius: AppRadius.base,
      semanticLabel: '$_ago: ${summary.memory.title}. Open this memory',
      // No hero here: the same memory may also be on the Recent shelf, and
      // one screen can't fly two copies.
      background: MdLocalPhoto(path: summary.coverPhoto?.thumbnailPath),
      overlay: [
        Positioned(
          top: AppSpacing.md,
          left: AppSpacing.md,
          child: MdSticker(
            label: _ago,
            icon: LucideIcons.history,
            tilt: -0.05,
            delay: const Duration(milliseconds: 300),
          ),
        ),
        Positioned(
          left: AppSpacing.md,
          right: AppSpacing.md,
          bottom: AppSpacing.md,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                summary.memory.title,
                style: AppTypography.heading3.copyWith(
                  color: AppColors.warmCream,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xxs),
              // An icon, not "→": the bundled Latin font subset has no arrow
              // glyph.
              Row(
                children: [
                  Text(
                    'Relive it',
                    style: AppTypography.label.copyWith(
                      color: AppColors.filmYellow,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(
                    LucideIcons.arrowRight,
                    size: AppIconSizes.sm,
                    color: AppColors.filmYellow,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../config/constant/app_colors.dart';
import '../../../../../config/constant/app_spacing.dart';
import '../../../../../config/constant/app_typography.dart';
import '../../atoms/common/md_pressable_scale.dart';

/// The welcome nudge shown when the app opens: one line inviting people to
/// create a quest. Tapping it takes you to the quests; the plus icon on the
/// right opens the new-quest flow. Copy follows the product line "Do
/// something together. Take the picture. Keep the memory." (CLAUDE.md §1,
/// §57, design system §63).
///
/// ```text
/// ╭────────────────────────────────────────╮
/// │ (✦)  Create a quest                 (+)│
/// │      Do it together. Keep the memory.  │
/// ╰────────────────────────────────────────╯
/// ```
class MdQuestPromptBar extends StatelessWidget {
  const MdQuestPromptBar({
    super.key,
    required this.onTap,
    required this.onCreate,
  });

  static const _title = 'Create a quest';
  static const _subtitle = 'Do it together. Keep the memory.';

  final VoidCallback onTap;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.base);

    return MdPressableScale(
      enabled: true,
      scale: 0.98,
      // Frosted glass: what scrolls behind is blurred, under a dark tint
      // that keeps the light text readable, and a hairline catches the light.
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              color: AppColors.dock.withValues(alpha: 0.62),
              border: Border.all(
                color: AppColors.onCamera.withValues(alpha: 0.18),
              ),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      button: true,
                      label: '$_title. $_subtitle',
                      excludeSemantics: true,
                      // No ink: the card's own press-scale is the feedback.
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onTap,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.ms),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.onCamera.withValues(
                                    alpha: 0.08,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  LucideIcons.sparkles,
                                  size: AppIconSizes.lg,
                                  color: AppColors.softPeach,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.ms),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _title,
                                      style: AppTypography.heading3.copyWith(
                                        color: AppColors.warmCream,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: AppSpacing.xxs),
                                    Text(
                                      _subtitle,
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.onDockMuted,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onCreate,
                    tooltip: 'Create a quest',
                    icon: const Icon(LucideIcons.plus),
                    iconSize: AppIconSizes.md,
                    color: AppColors.onDockMuted,
                    style: IconButton.styleFrom(
                      overlayColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

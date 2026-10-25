import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../config/constant/app_colors.dart';
import '../../../../../config/constant/app_spacing.dart';
import '../../../../../config/constant/app_typography.dart';
import '../../../../domain/people/enum/mood.dart';
import '../../atoms/common/md_sticker.dart';
import '../../atoms/people/md_profile_button.dart';
import 'md_mood_pill.dart';

/// How you feel on the left, you (the profile) on the right, then today's
/// date, the greeting and the invitation, with "memory" inked in coral so
/// the one thing the app is for stands out.
class MdHomeGreeting extends StatelessWidget {
  const MdHomeGreeting({
    super.key,
    required this.greeting,
    required this.today,
    required this.mood,
    required this.avatarId,
    required this.onOpenMood,
    required this.onOpenProfile,
  });

  final String greeting;
  final DateTime today;
  final Mood? mood;
  final String? avatarId;
  final VoidCallback onOpenMood;
  final VoidCallback onOpenProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: MdMoodPill(mood: mood, onTap: onOpenMood),
              ),
            ),
            MdProfileButton(avatarId: avatarId, onTap: onOpenProfile),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        MdSticker(
          label: DateFormat('EEEE, MMM d').format(today),
          icon: LucideIcons.sun,
          delay: const Duration(milliseconds: 250),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(greeting, style: AppTypography.bodyMuted),
        const SizedBox(height: AppSpacing.xs),
        Semantics(
          header: true,
          label: "Let's make a memory.",
          excludeSemantics: true,
          child: Text.rich(
            TextSpan(
              text: "Let's make a ",
              children: [
                TextSpan(
                  text: 'memory.',
                  style: AppTypography.display.copyWith(
                    color: AppColors.coralInk,
                  ),
                ),
              ],
            ),
            style: AppTypography.display,
          ),
        ),
      ],
    );
  }
}

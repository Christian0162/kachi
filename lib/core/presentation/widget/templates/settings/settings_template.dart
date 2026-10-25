import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../../config/constant/app_colors.dart';
import '../../../../../config/constant/app_spacing.dart';
import '../../../../../config/constant/app_typography.dart';
import '../../../types/settings/backup_state.dart';
import '../../atoms/people/md_avatar_image.dart';
import '../../molecules/common/md_app_card.dart';
import '../../organisms/settings/md_backup_card.dart';
import '../../organisms/common/md_app_scaffold.dart';

/// Quiet, short settings: mostly reassurance that memories are private and
/// stay on this device, plus a way into the account.
class SettingsTemplate extends StatelessWidget {
  const SettingsTemplate({
    super.key,
    this.name,
    this.avatarId,
    required this.onOpenProfile,
    required this.backup,
    required this.onBackupToggled,
    required this.onBackUpNow,
    required this.onOpenAccount,
    required this.onOpenLicenses,
  });

  /// Your name, if you've set one.
  final String? name;
  final String? avatarId;
  final VoidCallback onOpenProfile;
  final BackupState backup;
  final ValueChanged<bool> onBackupToggled;
  final VoidCallback onBackUpNow;
  final VoidCallback onOpenAccount;

  final VoidCallback onOpenLicenses;

  @override
  Widget build(BuildContext context) {
    return MdAppScaffold(
      showAppBar: true,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.xxl,
        ),
        children: [
          Semantics(
            header: true,
            child: Text('Settings', style: AppTypography.heading1),
          ),
          const SizedBox(height: AppSpacing.lg),
          MdAppCard(
            color: AppColors.softPeach,
            elevated: false,
            padding: const EdgeInsets.all(AppSpacing.ml),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(LucideIcons.lock),
                const SizedBox(width: AppSpacing.ms),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Private by design', style: AppTypography.heading3),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Your photos and memories live on this phone. A '
                        'memory only goes online if you invite a friend to '
                        'it, or turn on backup below, and then as a smaller '
                        'copy. Your account details (email, name and profile '
                        'photo) are stored online too.',
                        style: AppTypography.body,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          MdBackupCard(
            backup: backup,
            onToggled: onBackupToggled,
            onBackUpNow: onBackUpNow,
          ),
          const SizedBox(height: AppSpacing.lg),
          MdAppCard(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: ListTile(
              leading: MdAvatarImage(avatarId: avatarId, radius: 20),
              title: const Text('Profile settings'),
              subtitle: Text(
                name == null || name!.trim().isEmpty
                    ? 'Your name and avatar'
                    : name!.trim(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: onOpenProfile,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          MdAppCard(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: ListTile(
              leading: const Icon(LucideIcons.circleUser),
              title: const Text('Your account'),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: onOpenAccount,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          MdAppCard(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: ListTile(
              leading: const Icon(LucideIcons.fileText),
              title: const Text('Open-source licenses'),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: onOpenLicenses,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_router.dart';
import '../../view_model/homes/profile_view_model.dart';
import '../../view_model/settings/backup_view_model.dart';
import '../../widget/templates/settings/settings_template.dart';

/// Settings. Design lives in [SettingsTemplate].
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(backupViewModelProvider.notifier);

    return SettingsTemplate(
      name: ref.watch(selfPersonProvider).value?.name,
      avatarId: ref.watch(avatarSettingProvider).value,
      onOpenProfile: () => context.push(AppRoutes.profileSettings),
      backup: ref.watch(backupViewModelProvider),
      onBackupToggled: (enabled) => viewModel.setEnabled(enabled: enabled),
      onBackUpNow: viewModel.backUpNow,
      onOpenAccount: () => context.push(AppRoutes.account),
      onOpenLicenses: () =>
          showLicensePage(context: context, applicationName: 'Kachi'),
    );
  }
}

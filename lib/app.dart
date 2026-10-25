import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/constant/app_theme.dart';
import 'config/routes/app_router.dart';
import 'core/presentation/view_model/settings/backup_view_model.dart';

class KachiApp extends ConsumerWidget {
  const KachiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    // Catches up any backup the person turned on, when the app opens.
    ref.watch(backupCatchUpProvider);

    return MaterialApp.router(
      title: 'Kachi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}

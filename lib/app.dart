import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/mob_theme.dart';

class MobKitchenApp extends ConsumerWidget {
  const MobKitchenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'SimmerLink',
      debugShowCheckedModeBanner: false,
      theme: MobTheme.darkTheme,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}

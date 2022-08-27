import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/shared/shared.dart';

import 'features/features.dart';

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    ref.read(themeModeProvider.notifier).loadThemeMode();
    ref.read(tasksClearPeriodProvider.notifier).loadTasksClearPeriod();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme light = const ColorScheme.light(
      primary: Colors.blue,
      tertiary: Colors.green,
    );
    ColorScheme dark = const ColorScheme.dark(
      primary: Colors.blueAccent,
      tertiary: Colors.greenAccent,
    );

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final ColorScheme lightColorScheme = lightDynamic?.copyWith(
              surface: lightDynamic.onInverseSurface,
            ) ??
            light;
        final ColorScheme darkColorScheme = darkDynamic?.copyWith() ?? dark;

        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final ThemeMode themeMode = ref.watch(themeModeProvider);

            return MaterialApp(
              theme: _configureThemeData(lightColorScheme),
              darkTheme: _configureThemeData(darkColorScheme),
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              home: const TasksScreen(),
            );
          },
        );
      },
    );
  }

  ThemeData _configureThemeData(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      bottomAppBarColor: colorScheme.surfaceVariant,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
      ),
    );
  }
}

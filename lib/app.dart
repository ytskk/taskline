import 'package:dynamic_color/dynamic_color.dart';
// import 'package:dynamic_colorscheme/dynamic_colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/shared/providers/theme_provider.dart';

import 'features/features.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    ColorScheme light = const ColorScheme.light();
    ColorScheme dark = const ColorScheme.dark();

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final ThemeMode themeMode =
                ref.watch(themeModeProvider).loadThemeMode();

            return MaterialApp(
              theme: ThemeData(
                colorScheme: lightDynamic?.copyWith(
                      surface: lightDynamic.onInverseSurface,
                    ) ??
                    light,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkDynamic ?? dark,
                brightness: Brightness.dark,
                useMaterial3: true,
              ),
              themeMode: themeMode,
              home: const TasksScreen(),
            );
          },
        );
      },
    );
  }
}

import 'dart:developer';

import 'package:dynamic_colorscheme/dynamic_colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/shared/providers/theme_provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'features/features.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ColorScheme? m3Light;
  ColorScheme? m3Dark;

  @override
  Widget build(BuildContext context) {
    ColorScheme light = const ColorScheme.light();
    ColorScheme dark = const ColorScheme.dark();

    return DynamicColorBuilder(
      builder: (CorePalette? palette) {
        if (palette != null) {
          m3Light = DynamicColorScheme.generate(palette, dark: false);
          m3Dark = DynamicColorScheme.generate(palette, dark: true);
        }

        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final ThemeMode themeMode =
                ref.watch(themeModeProvider).loadThemeMode();

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: m3Light == null
                  ? ThemeData(
                      colorScheme: light,
                      useMaterial3: true,
                    )
                  : ThemeData(
                      colorScheme: m3Light,
                      useMaterial3: true,
                    ),
              darkTheme: m3Dark == null
                  ? ThemeData(
                      colorScheme: dark,
                      useMaterial3: true,
                      brightness: Brightness.dark,
                    )
                  : ThemeData(
                      colorScheme: m3Dark,
                      useMaterial3: true,
                      brightness: Brightness.dark,
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

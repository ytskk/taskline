import 'package:flutter/material.dart';
import 'package:taskline/features/features.dart';

typedef ColorSchemeMap = Map<String, dynamic>;

class TestThemeScreen extends StatelessWidget {
  const TestThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<ColorSchemeMap> colors = [
      {
        'color': colorScheme.primary,
        'text': 'Primary',
      },
      {
        'color': colorScheme.onPrimary,
        'text': 'on Primary',
      },
      {
        'color': colorScheme.primaryContainer,
        'text': 'Primary container',
      },
      {
        'color': colorScheme.onPrimaryContainer,
        'text': 'on Primary container',
      },
      {
        'color': colorScheme.secondary,
        'text': 'Secondary',
      },
      {
        'color': colorScheme.onSecondary,
        'text': 'on Secondary',
      },
      {
        'color': colorScheme.secondaryContainer,
        'text': 'Secondary container',
      },
      {
        'color': colorScheme.onSecondaryContainer,
        'text': 'on Secondary container',
      },
      {
        'color': colorScheme.tertiary,
        'text': 'Tertiary',
      },
      {
        'color': colorScheme.onTertiary,
        'text': 'on Tertiary',
      },
      {
        'color': colorScheme.tertiaryContainer,
        'text': 'Tertiary container',
      },
      {
        'color': colorScheme.onTertiaryContainer,
        'text': 'on Tertiary container',
      },
      {
        'color': colorScheme.surface,
        'text': 'Surface',
      },
      {
        'color': colorScheme.onSurface,
        'text': 'on Surface',
      },
      {
        'color': colorScheme.surfaceVariant,
        'text': 'Surface variant',
      },
      {
        'color': colorScheme.onSurfaceVariant,
        'text': 'On surface variant',
      },
      {
        'color': colorScheme.background,
        'text': 'Background',
      },
      {
        'color': colorScheme.onBackground,
        'text': 'on Background',
      },
      {
        'color': colorScheme.error,
        'text': 'Error',
      },
      {
        'color': colorScheme.onError,
        'text': 'on Error',
      },
      {
        'color': colorScheme.errorContainer,
        'text': 'Error container',
      },
      {
        'color': colorScheme.outline,
        'text': 'Outline',
      },
      {
        'color': colorScheme.shadow,
        'text': 'Shadow',
      },
      {
        'color': colorScheme.inversePrimary,
        'text': 'Inverse primary',
      },
      {
        'color': colorScheme.inverseSurface,
        'text': 'Inverse surface',
      },
      {
        'color': colorScheme.onInverseSurface,
        'text': 'on Inverse surface',
      },
      {
        'color': colorScheme.surfaceTint,
        'text': 'Surface tint',
      },
    ];

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar.large(
              title: Text('Generated Colors'),
            ),
          ];
        },
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: colors.length,
                  (context, index) {
                    final colorData = colors.elementAt(index);

                    return TestThemeItem(
                      colorName: colorData['text'],
                      color: colorData['color'],
                    );
                  },
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  mainAxisExtent: 160.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

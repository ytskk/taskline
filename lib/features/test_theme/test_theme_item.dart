import 'package:flutter/material.dart';

class TestThemeItem extends StatelessWidget {
  const TestThemeItem({
    Key? key,
    required this.color,
    required this.colorName,
  }) : super(key: key);

  final Color color;
  final String colorName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Center(
            child: Text(
              ColorX(color).toHexTriplet(),
              style: TextStyle(
                color: color.computeLuminance() < 0.479
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
        Text(colorName),
      ],
    );
  }
}

extension ColorX on Color {
  String toHexTriplet() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

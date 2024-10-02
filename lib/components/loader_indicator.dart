import 'package:flutter/material.dart';

class LoaderIndicator extends StatelessWidget {
  const LoaderIndicator({
    this.colored = Colors.purple,
    this.value,
    this.isCenter = true,
    this.isIndicator = false,
    super.key,
  });

  final Color colored;
  final double? value;
  final bool isCenter;
  final bool isIndicator;

  @override
  Widget build(BuildContext context) {
    Widget indicator = CircularProgressIndicator(color: colored, value: value);
    if (isIndicator) {
      indicator = SizedBox(height: 24, width: 24, child: indicator);
    }
    if (isCenter) {
      return Center(child: indicator);
    }

    return indicator;
  }
}

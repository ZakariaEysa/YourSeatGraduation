import 'package:flutter/material.dart';

class UnselectedOptionWidget extends StatelessWidget {
  final String unSelectedTitle;
  const UnselectedOptionWidget({required this.unSelectedTitle, super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [Text(unSelectedTitle, style: theme.textTheme.labelLarge)],
    );
  }
}

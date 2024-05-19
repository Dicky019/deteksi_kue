import 'package:flutter/material.dart';

mixin RouterMixin {
  navigation(
    BuildContext context,
    Widget Function(BuildContext context) builder,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: builder),
    );
  }
}

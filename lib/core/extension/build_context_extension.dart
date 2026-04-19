import 'package:flutter/material.dart';

import '../core.dart';

extension BuildContextEx on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  AppColors get appColors => theme.extension<AppColors>()!;
}
import 'package:flutter/material.dart';
import 'package:core_jung/core_jung.dart';

import 'package:ruay_jung/src/theme/app_colors.dart';

/// Shared header for pushed pages — a back button, a title, a bottom
/// border, in Ruay Jung's own passbook-cover colors.
class RjPageHeader extends StatelessWidget implements PreferredSizeWidget {
  const RjPageHeader({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return MiniAppPageHeader(
      title: title,
      backgroundColor: colors.cover,
      borderColor: colors.onCover.withValues(alpha: 0.12),
      badgeColor: colors.coverDeep,
      iconColor: colors.onCover,
      titleColor: colors.onCover,
      actions: actions,
    );
  }
}

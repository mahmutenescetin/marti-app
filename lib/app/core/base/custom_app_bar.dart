import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final double? elevation;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.bottom,
    this.backgroundColor,
    this.elevation,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      bottom: bottom,
      backgroundColor: backgroundColor,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );
}

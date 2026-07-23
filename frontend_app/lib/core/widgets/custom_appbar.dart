import 'package:flutter/material.dart';

/// Enum to control title alignment in CustomAppBar
enum TitleAlignment { center, left }

/// A custom AppBar widget built by developer.
/// Supports title, actions, leading, background color, elevation, optional height, title alignment, and automatically adding back button.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final double elevation;
  final List<Widget>? actions;
  final Widget? leading;
  final double? height;
  final TitleAlignment titleAlignment;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.elevation = 0.5,
    this.actions,
    this.leading,
    this.height,
    this.titleAlignment = TitleAlignment.center,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget? leadingWidget = leading;

    // Automatically add a back button if implied and possible
    if (leadingWidget == null &&
        automaticallyImplyLeading &&
        Navigator.canPop(context)) {
      leadingWidget = IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back),
      );
    }

    return Material(
      color: backgroundColor ?? colorScheme.primary,
      elevation: elevation,
      child: SafeArea(
        child: Container(
          height: preferredSize.height,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              leadingWidget ?? const SizedBox.shrink(),
              Expanded(
                child: Align(
                  alignment: titleAlignment == TitleAlignment.center
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: Text(
                    title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              ...?actions,
            ],
          ),
        ),
      ),
    );
  }
}

/// A reusable back button matching the AppTheme style.
class CustomBackButton extends StatelessWidget {
  final double size;
  final Color? color;
  final VoidCallback? onPressed;

  const CustomBackButton({
    super.key,
    this.size = 24,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap:
          onPressed ??
          () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
      child: Icon(Icons.arrow_back, size: size, color: colorScheme.onSecondary),
    );
  }
}

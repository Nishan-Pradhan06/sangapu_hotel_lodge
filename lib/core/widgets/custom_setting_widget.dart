import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool showTrailing;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      splashColor: Colors.transparent,
      trailing: showTrailing ? const Icon(Icons.arrow_right_rounded) : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_statements/blocs/export_excel/export_statement_bloc.dart';

/// A modal bottom sheet that presents export options (PDF / Excel) for
/// the statement list. Call [ExportBottomSheet.show] to display it.
class ExportBottomSheet extends StatelessWidget {
  const ExportBottomSheet({super.key});

  /// Convenience method to push the bottom sheet onto the navigator stack.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ExportBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text('Export Statement', style: textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'Choose a format to download your statement',
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 24),

          // PDF option
          _ExportOptionTile(
            icon: Icons.picture_as_pdf_outlined,
            iconColor: colorScheme.error,
            iconBackgroundColor: colorScheme.error.withValues(alpha: 0.1),
            title: 'Export as PDF',
            subtitle: 'Download a printable PDF document',
            onTap: () {
              Navigator.of(context).pop();
              // TODO: trigger PDF export
            },
          ),
          const SizedBox(height: 12),

          // Excel option
          _ExportOptionTile(
            icon: Icons.table_chart_outlined,
            iconColor: const Color(0xFF217346), // Excel green
            iconBackgroundColor: const Color(0xFF217346).withValues(alpha: 0.1),
            title: 'Export as Excel',
            subtitle: 'Download a spreadsheet (.xlsx)',
            onTap: () {
              Navigator.of(context).pop();
              context.read<ExportStatementBloc>().add(
                const ExportStatementEvent.exportExcel(),
              );
            },
          ),
          const SizedBox(height: 8),

          // Cancel button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Private reusable tile widget
// ---------------------------------------------------------------------------

class _ExportOptionTile extends StatelessWidget {
  const _ExportOptionTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),

              // Labels
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text(subtitle, style: textTheme.bodySmall),
                  ],
                ),
              ),

              // Chevron
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

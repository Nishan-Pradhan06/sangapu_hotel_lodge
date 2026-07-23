import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export_statements/blocs/export_pdf/export_pdf_bloc.dart';
import '../../export_statements/blocs/export_excel/export_statement_bloc.dart';
import '../widgets/export_option_tile.dart';

import '../../statements/repository/transcation_repository.dart';

/// A modal bottom sheet that presents export options (PDF / Excel) for
/// the statement list. Call [ExportBottomSheet.show] to display it.
class ExportBottomSheet extends StatelessWidget {
  final StatementFilter? filter;

  const ExportBottomSheet({super.key, this.filter});

  /// Convenience method to push the bottom sheet onto the navigator stack.
  static Future<void> show(BuildContext context, {StatementFilter? filter}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExportBottomSheet(filter: filter),
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
          ExportOptionTile(
            icon: Icons.picture_as_pdf_outlined,
            iconColor: colorScheme.error,
            iconBackgroundColor: colorScheme.error.withValues(alpha: 0.1),
            title: 'Export as PDF',
            subtitle: 'Download a printable PDF document',
            onTap: () {
              Navigator.pop(context);
              context.read<ExportPdfBloc>().add(
                ExportPdfEvent.exportPdf(
                  type: filter?.type,
                  date: filter?.date,
                  ordering: filter?.ordering,
                  startDate: filter?.dateFrom,
                  endDate: filter?.dateTo,
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          // Excel option
          ExportOptionTile(
            icon: Icons.table_chart_outlined,
            iconColor: colorScheme.primary,
            iconBackgroundColor: colorScheme.primary.withValues(alpha: 0.1),
            title: 'Export as Excel',
            subtitle: 'Download a spreadsheet document',
            onTap: () {
              Navigator.pop(context);
              context.read<ExportStatementBloc>().add(
                ExportStatementEvent.exportExcel(
                  type: filter?.type,
                  date: filter?.date,
                  ordering: filter?.ordering,
                  startDate: filter?.dateFrom,
                  endDate: filter?.dateTo,
                ),
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

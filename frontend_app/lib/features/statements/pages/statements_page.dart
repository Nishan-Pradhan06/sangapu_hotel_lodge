import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:sangapu/core/widgets/custom_toast.dart';
import '../../export_statements/blocs/export_excel/export_statement_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_padding.dart';
import '../bloc/statements_bloc.dart';
import '../widgets/filter_chip.dart';
import '../widgets/transcation_tile.dart';
import 'export_page.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({super.key});

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Semantic amount colors sourced from AppTheme, not hardcoded here.
    final negativeColor = colorScheme.error;
    final positiveColor = AppTheme.success;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('View Statement', style: textTheme.titleLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () => ExportBottomSheet.show(context),
              child: Icon(
                Icons.download_outlined,
                color: colorScheme.onSurface,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<ExportStatementBloc, ExportStatementState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading Excel file...')),
              );
            },
            loaded: (bytes) async {
              try {
                final dir = await getApplicationDocumentsDirectory();
                final file = File(
                  '${dir.path}/statement_${DateTime.now().millisecondsSinceEpoch}.xlsx',
                );
                await file.writeAsBytes(bytes);
                if (context.mounted) {
                  CustomToast.showSuccess('Excel downloaded successfully');
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Excel downloaded successfully'),
                      action: SnackBarAction(
                        label: 'Open',
                        onPressed: () => OpenFile.open(file.path),
                      ),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to save file: $e')),
                  );
                }
              }
            },
            failure: (failure) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Export failed: ${failure.message}')),
              );
            },
          );
        },
        child: SafeArea(
          child: RefreshIndicator.adaptive(
            onRefresh: () {
              context.read<StatementsBloc>().add(
                const StatementsEvent.getStatement(),
              );
              return Future.value();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: CustomPadding(
                horizontal: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        FilterChipWidget(
                          label: "Date",
                          color: colorScheme.outline,
                          textColor: colorScheme.onSurface,
                        ),
                        const SizedBox(width: 8),
                        FilterChipWidget(
                          label: "Money Movement",
                          color: colorScheme.outline,
                          textColor: colorScheme.onSurface,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<StatementsBloc, StatementsState>(
                      builder: (context, state) {
                        return state.when(
                          initial: () => SizedBox(),
                          loading: () => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          failure: (failure) =>
                              Text('Error: ${failure.message}'),
                          loaded: (data) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              shrinkWrap: true,
                              itemCount: data.transactions.length,
                              itemBuilder: (context, index) {
                                final transaction = data.transactions[index];
                                return Column(
                                  children: [
                                    TransactionTile(
                                      title: Text(
                                        "${transaction.category} | ${transaction.remarks}",
                                        style: textTheme.titleSmall,
                                      ),
                                      dateTime: Text(
                                        transaction.nepaliDate,
                                        style: textTheme.bodySmall,
                                      ),
                                      amount: Text(
                                        " ${transaction.type == 'Income' ? '+' : '-'} ${transaction.amount.toString()}",
                                        style: textTheme.titleMedium?.copyWith(
                                          color: transaction.type == 'Income'
                                              ? positiveColor
                                              : negativeColor,
                                        ),
                                      ),
                                      balance: Text(
                                        // data.summary.netBalance.toString(),
                                        "",
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: colorScheme.outline,
                                      height: 32,
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      // FAB automatically picks up AppTheme.floatingActionButtonTheme
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.filter_alt),
        label: const Text("All Filters"),
      ),
    );
  }
}

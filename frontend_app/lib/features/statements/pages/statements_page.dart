import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_padding.dart';
import '../bloc/statements_bloc.dart';
import '../cubits/statement_filter_cubit.dart';
import '../widgets/filter_chip.dart';
import '../widgets/date_filter_bottom_sheet.dart';
import '../widgets/money_movement_bottom_sheet.dart';
import '../widgets/transcation_tile.dart';
import 'export_page.dart';
import '../../export_statements/blocs/export_pdf/export_pdf_bloc.dart';
import '../../export_statements/blocs/export_excel/export_statement_bloc.dart';
import 'package:open_file/open_file.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../core/utils/download_helper.dart';

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

    return MultiBlocListener(
      listeners: [
        BlocListener<ExportPdfBloc, ExportPdfState>(
          listener: (context, state) async {
            state.when(
              initial: () {},
              loading: () {
                CustomToast.showInfo('Downloading PDF...');
              },
              loaded: (bytes) async {
                try {
                  final filePath = await DownloadHelper.saveDocument(
                    fileName:
                        'statement_${DateTime.now().millisecondsSinceEpoch}',
                    bytes: bytes,
                    extension: 'pdf',
                  );
                  if (context.mounted) {
                    CustomToast.showSuccess('PDF downloaded successfully');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Tap to open the file'),
                        action: SnackBarAction(
                          label: 'Open',
                          onPressed: () => OpenFile.open(filePath),
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  CustomToast.showError(e.toString());
                }
              },
              failure: (failure) {
                CustomToast.showError(failure.message);
              },
            );
          },
        ),
        BlocListener<ExportStatementBloc, ExportStatementState>(
          listener: (context, state) async {
            state.when(
              initial: () {},
              loading: () {
                CustomToast.showInfo('Downloading Excel...');
              },
              loaded: (bytes) async {
                try {
                  final filePath = await DownloadHelper.saveDocument(
                    fileName:
                        'statement_${DateTime.now().millisecondsSinceEpoch}',
                    bytes: bytes,
                    extension: 'xlsx',
                  );
                  if (context.mounted) {
                    CustomToast.showSuccess('Excel downloaded successfully');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Tap to open the file'),
                        action: SnackBarAction(
                          label: 'Open',
                          onPressed: () => OpenFile.open(filePath),
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  CustomToast.showError(e.toString());
                }
              },
              failure: (failure) {
                CustomToast.showError(failure.message);
              },
            );
          },
        ),
      ],
      child: Scaffold(
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
        body: SafeArea(
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
                    BlocBuilder<StatementFilterCubit, StatementFilterState>(
                      builder: (context, filterState) {
                        final hasDateFilter = filterState.dateFrom != null || filterState.dateTo != null;
                        final hasTypeFilter = filterState.type != null;

                        return Row(
                          children: [
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => DateFilterBottomSheet.show(context),
                              child: FilterChipWidget(
                                label: "Date",
                                color: hasDateFilter ? colorScheme.primary : colorScheme.outline,
                                textColor: hasDateFilter ? colorScheme.primary : colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => MoneyMovementBottomSheet.show(context),
                              child: FilterChipWidget(
                                label: "Money Movement",
                                color: hasTypeFilter ? colorScheme.primary : colorScheme.outline,
                                textColor: hasTypeFilter ? colorScheme.primary : colorScheme.onSurface,
                              ),
                            ),
                          ],
                        );
                      },
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

        // FAB automatically picks up AppTheme.floatingActionButtonTheme
        floatingActionButton: BlocBuilder<StatementFilterCubit, StatementFilterState>(
          builder: (context, filterState) {
            final hasActiveFilter = context.read<StatementFilterCubit>().hasActiveFilter;
            return FloatingActionButton.extended(
              onPressed: () {},
              icon: Icon(
                hasActiveFilter ? Icons.filter_alt : Icons.filter_alt_outlined,
              ),
              label: Text(hasActiveFilter ? "Filters Applied" : "All Filters"),
              backgroundColor: hasActiveFilter ? colorScheme.primary : null,
              foregroundColor: hasActiveFilter ? colorScheme.onPrimary : null,
            );
          },
        ),
      ),
    );
  }
}

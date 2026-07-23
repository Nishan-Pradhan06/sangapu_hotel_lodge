import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import '../cubits/statement_filter_cubit.dart';
import '../bloc/statements_bloc.dart';
import '../../../core/widgets/custom_button.dart';

class DateFilterBottomSheet extends StatefulWidget {
  const DateFilterBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<StatementFilterCubit>(),
        child: BlocProvider.value(
          value: context.read<StatementsBloc>(),
          child: const DateFilterBottomSheet(),
        ),
      ),
    );
  }

  @override
  State<DateFilterBottomSheet> createState() => _DateFilterBottomSheetState();
}

class _DateFilterBottomSheetState extends State<DateFilterBottomSheet> {
  String _selectedOption = 'Custom Date Range';
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    final filterState = context.read<StatementFilterCubit>().state;
    _startDate = filterState.dateFrom;
    _endDate = filterState.dateTo;

    if (_startDate == null && _endDate == null) {
      _selectedOption = 'Custom Date Range';
    } else {
      _selectedOption = 'Custom Date Range';
    }
  }

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
      final now = DateTime.now();
      final nowBS = NepaliDateTime.now();

      if (option == 'This Week') {
        _startDate = now.subtract(
          Duration(days: now.weekday == 7 ? 0 : now.weekday),
        );
        _endDate = now;
      } else if (option == 'This Month') {
        final startBS = NepaliDateTime(nowBS.year, nowBS.month, 1);
        _startDate = startBS.toDateTime();
        _endDate = now;
      } else if (option == 'Last Quarter') {
        int qMonth = nowBS.month - 3;
        int qYear = nowBS.year;
        if (qMonth < 1) {
          qMonth += 12;
          qYear -= 1;
        }
        final startBS = NepaliDateTime(qYear, qMonth, 1);
        _startDate = startBS.toDateTime();
        _endDate = now;
      } else {
        _startDate = null;
        _endDate = null;
      }
    });
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final initialDate = isStart
        ? (_startDate?.toNepaliDateTime() ?? NepaliDateTime.now())
        : (_endDate?.toNepaliDateTime() ??
              _startDate?.toNepaliDateTime() ??
              NepaliDateTime.now());

    final pickedDate = await showMaterialDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: NepaliDateTime(2000, 1, 1),
      lastDate: NepaliDateTime(2100, 12, 30),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedOption = 'Custom Date Range';
        final dateTime = pickedDate.toDateTime();
        if (isStart) {
          _startDate = dateTime;
          if (_endDate != null && _endDate!.isBefore(dateTime)) {
            _endDate = null;
          }
        } else {
          _endDate = dateTime;
          if (_startDate != null && _startDate!.isAfter(dateTime)) {
            _startDate = dateTime;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 24.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildRadioOption(
            'This Week',
            _formatRange(
              DateTime.now().subtract(
                Duration(
                  days: DateTime.now().weekday == 7
                      ? 0
                      : DateTime.now().weekday,
                ),
              ),
              DateTime.now(),
            ),
          ),
          _buildRadioOption(
            'This Month',
            _formatRange(
              NepaliDateTime(
                NepaliDateTime.now().year,
                NepaliDateTime.now().month,
                1,
              ).toDateTime(),
              DateTime.now(),
            ),
          ),
          _buildRadioOption('Last Quarter', _getLastQuarterString()),
          _buildRadioOption('Custom Date Range', null),

          if (_selectedOption == 'Custom Date Range') ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDateField('Start Date', _startDate, true),
                ),
                const SizedBox(width: 16),
                Expanded(child: _buildDateField('End Date', _endDate, false)),
              ],
            ),
          ],

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'Show Transactions',
              onPressed: () {
                if (_startDate != null || _endDate != null) {
                  context.read<StatementFilterCubit>().setDateRange(
                    _startDate ?? DateTime(2000),
                    _endDate ?? DateTime.now(),
                  );
                } else {
                  context.read<StatementFilterCubit>().clearDateRange();
                }

                final filter = context.read<StatementFilterCubit>().toFilter();
                context.read<StatementsBloc>().add(
                  StatementsEvent.getStatement(filter: filter),
                );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String title, String? subtitle) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => _selectOption(title),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.bodyLarge),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Radio<String>(
              value: title,
              groupValue: _selectedOption,
              activeColor: theme.colorScheme.primary,
              fillColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return theme.colorScheme.primary;
                }
                return theme.colorScheme.outline;
              }),
              onChanged: (val) {
                if (val != null) _selectOption(val);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, bool isStart) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _pickDate(context, isStart),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null
                      ? NepaliDateFormat(
                          'dd MMM yyyy',
                        ).format(date.toNepaliDateTime())
                      : 'Select',
                  style: theme.textTheme.bodyMedium,
                ),
                Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatRange(DateTime start, DateTime end) {
    final startBS = start.toNepaliDateTime();
    final endBS = end.toNepaliDateTime();
    final format = NepaliDateFormat('MMM dd');
    return '${format.format(startBS)} - ${format.format(endBS)}';
  }

  String _getLastQuarterString() {
    final nowBS = NepaliDateTime.now();
    int qMonth = nowBS.month - 3;
    int qYear = nowBS.year;
    if (qMonth < 1) {
      qMonth += 12;
      qYear -= 1;
    }
    final startBS = NepaliDateTime(qYear, qMonth, 1);
    return _formatRange(startBS.toDateTime(), DateTime.now());
  }
}

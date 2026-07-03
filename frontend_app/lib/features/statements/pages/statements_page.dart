import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_padding.dart';
import '../widgets/filter_chip.dart';
import '../widgets/transcation_tile.dart';

class StatementPage extends StatelessWidget {
  const StatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Semantic amount colors sourced from AppTheme, not hardcoded here.
    final positiveColor = AppTheme.success;
    final negativeColor = colorScheme.error;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('View Statement', style: textTheme.titleLarge),
        actions: [
          Icon(Icons.download_outlined, color: colorScheme.onSurface, size: 24),
        ],
      ),
      body: SafeArea(
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

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    TransactionTile(
                      title: Text(
                        "CIPS/Others: nishan/NEPALPAY QR ACCOUNT/ITAHARI NAMUNA COLLEGE /VIBOR",
                        style: textTheme.titleSmall,
                      ),
                      dateTime: Text(
                        "08:01 AM | 2 Jul 2026",
                        style: textTheme.bodySmall,
                      ),
                      amount: Text(
                        "-5,000.00",
                        style: textTheme.titleMedium?.copyWith(
                          color: negativeColor,
                        ),
                      ),
                      balance: Text(
                        "13,077.91",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Divider(color: colorScheme.outline, height: 32),

                    TransactionTile(
                      title: Text(
                        "Card 5th Installment Fee",
                        style: textTheme.titleSmall,
                      ),
                      dateTime: Text(
                        "08:57 PM | 1 Jul 2026",
                        style: textTheme.bodySmall,
                      ),
                      amount: Text(
                        "-400.00",
                        style: textTheme.titleMedium?.copyWith(
                          color: negativeColor,
                        ),
                      ),
                      balance: Text(
                        "18,077.91",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Divider(color: colorScheme.outline, height: 32),

                    TransactionTile(
                      title: Text(
                        "MOS::Professional Services",
                        style: textTheme.titleSmall,
                      ),
                      dateTime: Text(
                        "09:00 AM | 1 Jul 2026",
                        style: textTheme.bodySmall,
                      ),
                      amount: Text(
                        "-1,091.52",
                        style: textTheme.titleMedium?.copyWith(
                          color: negativeColor,
                        ),
                      ),
                      balance: Text(
                        "18,477.91",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Divider(color: colorScheme.outline, height: 32),

                    TransactionTile(
                      title: Text(
                        "LAW:1782875588504:GLBBNPKA",
                        style: textTheme.titleSmall,
                      ),
                      dateTime: Text(
                        "08:58 AM | 1 Jul 2026",
                        style: textTheme.bodySmall,
                      ),
                      amount: Text(
                        "+1,100.00",
                        style: textTheme.titleMedium?.copyWith(
                          color: positiveColor,
                        ),
                      ),
                      balance: Text(
                        "19,569.43",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Divider(color: colorScheme.outline, height: 32),

                    TransactionTile(
                      title: Text(
                        "CIPS/Others: khana /NEPALPAY QR ACCOUNT/ITAHARI NAMUNA COLLEGE /VIBOR",
                        style: textTheme.titleSmall,
                      ),
                      dateTime: Text(
                        "09:12 AM | 30 Jun 2026",
                        style: textTheme.bodySmall,
                      ),
                      amount: Text(
                        "-125.00",
                        style: textTheme.titleMedium?.copyWith(
                          color: negativeColor,
                        ),
                      ),
                      balance: Text(
                        "18,469.43",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
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

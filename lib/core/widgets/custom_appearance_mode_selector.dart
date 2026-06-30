import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/gobal_pages/settings/cubits/cubit/theme_appearance_cubit.dart';

enum AppearanceMode { system, dark, light }

class AppearanceModeSelector extends StatefulWidget {
  final AppearanceMode selectedMode;
  final ValueChanged<AppearanceMode>? onModeChanged;

  const AppearanceModeSelector({
    super.key,
    this.selectedMode = AppearanceMode.system,
    this.onModeChanged,
  });

  @override
  State<AppearanceModeSelector> createState() => _AppearanceModeSelectorState();
}

class _AppearanceModeSelectorState extends State<AppearanceModeSelector> {
  late AppearanceMode _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedMode = widget.selectedMode;
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width / 3.5;
    final double cardHeight = cardWidth * 1.6;

    // 👇 Wrap UI inside BlocBuilder so it rebuilds when theme changes
    return BlocBuilder<ThemeAppearanceCubit, ThemeAppearanceState>(
      builder: (context, state) {
        // 🔁 Sync with Cubit state
        _selectedMode = _mapThemeModeToAppearance(
          state.selectedThemeMode ?? ThemeMode.system,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildModeOption(
                mode: AppearanceMode.system,
                label: 'System',
                width: cardWidth,
                height: cardHeight,
              ),
              _buildModeOption(
                mode: AppearanceMode.dark,
                label: 'Dark',
                width: cardWidth,
                height: cardHeight,
              ),
              _buildModeOption(
                mode: AppearanceMode.light,
                label: 'Light',
                width: cardWidth,
                height: cardHeight,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModeOption({
    required AppearanceMode mode,
    required String label,
    required double width,
    required double height,
  }) {
    final isSelected = _selectedMode == mode;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedMode = mode);
        context.read<ThemeAppearanceCubit>().setTheme(
          _mapAppearanceToThemeMode(mode),
        );

        widget.onModeChanged?.call(mode);
      },
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.redAccent : Colors.grey.shade300,
                width: isSelected ? 3 : 1.5,
              ),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: Colors.redAccent.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: _buildPreview(mode),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.redAccent : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // Helper mapping functions 🔄
  ThemeMode _mapAppearanceToThemeMode(AppearanceMode mode) {
    switch (mode) {
      case AppearanceMode.dark:
        return ThemeMode.dark;
      case AppearanceMode.light:
        return ThemeMode.light;
      case AppearanceMode.system:
        return ThemeMode.system;
    }
  }

  AppearanceMode _mapThemeModeToAppearance(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return AppearanceMode.dark;
      case ThemeMode.light:
        return AppearanceMode.light;
      case ThemeMode.system:
        return AppearanceMode.system;
    }
  }

  Widget _buildPreview(AppearanceMode mode) {
    switch (mode) {
      case AppearanceMode.system:
        return _buildSystemPreview();
      case AppearanceMode.dark:
        return _buildDarkPreview();
      case AppearanceMode.light:
        return _buildLightPreview();
    }
  }

  Widget _buildSystemPreview() {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(child: Container(color: Colors.white)),
            Expanded(child: Container(color: Colors.black)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Row(
                spacing: 6,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 11,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Row(
                    children: [
                      Expanded(
                        child: ContentRow(
                          color: Colors.grey.shade200,
                          borderRadiusRight: 0,
                        ),
                      ),
                      Expanded(
                        child: ContentRow(
                          color: Colors.grey.shade800,
                          borderRadiusLeft: 0,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDarkPreview() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeaderBar(Colors.grey.shade900),
          const SizedBox(height: 8),
          ContentRow(color: Colors.grey.shade800),
          const SizedBox(height: 8),
          ContentRow(color: Colors.grey.shade800),
          const SizedBox(height: 8),
          ContentRow(color: Colors.grey.shade800),
        ],
      ),
    );
  }

  Widget _buildLightPreview() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeaderBar(Colors.grey.shade100),
          const SizedBox(height: 8),
          ContentRow(color: Colors.grey.shade200),
          const SizedBox(height: 8),
          ContentRow(color: Colors.grey.shade200),
          const SizedBox(height: 8),
          ContentRow(color: Colors.grey.shade200),
        ],
      ),
    );
  }

  Widget _buildHeaderBar(Color color) {
    return Row(
      spacing: 6,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(
          child: Container(
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class ContentRow extends StatelessWidget {
  final Color color;
  final double? borderRadiusRight;
  final double? borderRadiusLeft;

  const ContentRow({
    super.key,
    required this.color,
    this.borderRadiusRight,
    this.borderRadiusLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadiusLeft ?? 8),
          bottomLeft: Radius.circular(borderRadiusLeft ?? 8),
          bottomRight: Radius.circular(borderRadiusRight ?? 8),
          topRight: Radius.circular(borderRadiusRight ?? 8),
        ),
      ),
    );
  }
}

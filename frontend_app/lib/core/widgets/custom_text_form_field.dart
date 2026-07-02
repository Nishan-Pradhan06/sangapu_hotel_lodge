import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum CustomTextFieldType {
  text,
  email,
  password,
  number,
  phone,
  dropdown,
  search,
}

class CustomTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final CustomTextFieldType type;
  final Widget? leading;
  final Widget? trailing;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsetsGeometry contentPadding;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<String>? dropdownItems;
  final Function(String?)? onDropdownChanged;
  final int maxLines;
  final bool noBorder;
  final TextStyle? hintStyle;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.type = CustomTextFieldType.text,
    this.leading,
    this.trailing,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.borderRadius = 8.0,
    this.fillColor,
    this.borderColor,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 12,
    ),
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.dropdownItems,
    this.onDropdownChanged,
    this.maxLines = 1,
    this.noBorder = false,
    this.hintStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = false;
  String? _dropdownValue;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
    if (widget.type == CustomTextFieldType.dropdown &&
        widget.dropdownItems != null &&
        widget.dropdownItems!.isNotEmpty) {
      if (widget.controller != null &&
          widget.controller!.text.isNotEmpty &&
          widget.dropdownItems!.contains(widget.controller!.text)) {
        _dropdownValue = widget.controller!.text;
      } else {
        _dropdownValue = widget.dropdownItems!.first;
        if (widget.controller != null) {
          widget.controller!.text = _dropdownValue!;
        }
      }
    }
  }

  Future<void> _openSearchPage(BuildContext context) async {
    // final result = await Navigator.push<String>(
    //   context,
    //   MaterialPageRoute(builder: (_) => const SearchScreen()),
    // );

    // if (result != null && widget.controller != null) {
    //   setState(() => widget.controller!.text = result);
    //   widget.onChanged?.call(result);
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Dropdown Field
    if (widget.type == CustomTextFieldType.dropdown) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Text(widget.label!, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            initialValue: widget.dropdownItems!.contains(_dropdownValue)
                ? _dropdownValue
                : null,
            decoration: _buildDecoration(),
            items: widget.dropdownItems
                ?.map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              setState(() => _dropdownValue = value);
              widget.onDropdownChanged?.call(value);
              if (widget.controller != null && value != null) {
                widget.controller!.text = value;
              }
            },
            validator: widget.validator,
          ),
        ],
      );
    }

    // Search Field
    if (widget.type == CustomTextFieldType.search) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Text(widget.label!, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () => _openSearchPage(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: widget.controller,
                readOnly: true,
                decoration: _buildDecoration().copyWith(
                  hintText: widget.hint ?? 'Search...',
                  prefixIcon:
                      widget.leading ?? const Icon(Icons.search_rounded),
                  suffixIcon: widget.trailing,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Normal Text Field
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(widget.label!, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          obscureText: _obscure,
          keyboardType:
              widget.keyboardType ??
              (widget.type == CustomTextFieldType.email
                  ? TextInputType.emailAddress
                  : widget.type == CustomTextFieldType.phone
                  ? TextInputType.phone
                  : widget.type == CustomTextFieldType.number
                  ? TextInputType.number
                  : TextInputType.text),
          onChanged: widget.onChanged,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: widget.maxLines,
          decoration: _buildDecoration().copyWith(
            hintText: widget.hint,
            hintStyle: widget.hintStyle,
            prefixIcon: widget.leading,
            suffixIcon:
                widget.trailing ??
                (widget.type == CustomTextFieldType.password
                    ? IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      )
                    : null),
          ),
        ),
      ],
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: widget.fillColor ?? AppTheme.surfaceLight,
      contentPadding: widget.contentPadding,
      border: widget.noBorder
          ? InputBorder.none
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
            ),
      enabledBorder: widget.noBorder
          ? InputBorder.none
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: widget.borderColor ?? Colors.grey),
            ),
      focusedBorder: widget.noBorder
          ? InputBorder.none
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.borderColor ?? ColorScheme.of(context).primary,
                width: 2,
              ),
            ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(color: ColorScheme.of(context).error),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
    );
  }
}

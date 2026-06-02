// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../util/dimensions.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isPassword;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final bool? isEnabled;
  final int? maxLines;
  final TextCapitalization? capitalization;
  final IconData? prefixIcon;
  final bool? divider;

  const CustomTextField({
    super.key,
    this.hintText = 'Write something...',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSubmit,
    this.onChanged,
    this.prefixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.divider = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLines: widget.maxLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: widget.capitalization ?? TextCapitalization.none,
          enabled: widget.isEnabled,
          obscureText: widget.isPassword == true ? _obscureText : false,
          inputFormatters: _getInputFormatters(),
          decoration: _buildInputDecoration(context),

          onSubmitted: (text) {
            if (widget.nextFocus != null) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            } else if (widget.onSubmit != null) {
              widget.onSubmit!(text);
            }
          },
          onChanged: (text) {
            if (widget.onChanged != null) {
              widget.onChanged!(text);
            }
          },
        ),
        if (widget.divider == true)
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE,
            ),
            child: Divider(),
          )
        else
          const SizedBox(),
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
      ),

      isDense: true,

      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),

      hintText: widget.hintText,

      fillColor: Theme.of(context).cardColor,
      filled: true,

      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: Dimensions.FONT_SIZE_LARGE,
        color: Theme.of(context).hintColor,
      ),

      prefixIcon: _buildPrefixIcon(),

      prefixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),

      suffixIcon: widget.isPassword == true ? _buildSuffixIcon(context) : null,
    );
  }

  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon == null) return null;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Icon(
        widget.prefixIcon,
        size: 20,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget? _buildSuffixIcon(BuildContext context) {
    return IconButton(
      icon: Icon(
        _obscureText ? Icons.visibility_off : Icons.visibility,
        color: Theme.of(context).hintColor.withValues(alpha: 0.3),
      ),
      onPressed: _toggleObscureText,
    );
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (widget.inputType == TextInputType.phone) {
      return [FilteringTextInputFormatter.allow(RegExp('[0-9+]'))];
    }
    return null;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

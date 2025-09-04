import 'package:flutter/material.dart';
import 'package:study_box/core/theme/app_color.dart';

class CustomTextField extends StatefulWidget {
  // text
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  // icons
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? onSuffixIconPressed;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  // custom colors
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  // Border Radius
  final double borderRadius;
  // size
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final double? width;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.prefixIconColor,
    this.suffixIconColor,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderRadius = 12.0,
    this.contentPadding,
    this.height,
    this.width,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        validator: widget.validator,
        style: TextStyle(
          color: widget.textColor ?? Colors.black87,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          filled: true,
          fillColor: widget.fillColor ?? AppColors.getCardColor(context),
          labelStyle: TextStyle(
            color: widget.labelColor ??
                (_isFocused ? Colors.blue : Colors.grey[600]),
          ),
          hintStyle: TextStyle(
            color: widget.hintColor ?? Colors.grey[400],
            fontWeight: FontWeight.w800,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: widget.prefixIconColor ??
                      (_isFocused ? AppColors.primaryColor : Colors.grey[400]),
                )
              : null,
          suffixIcon: widget.suffixIcon != null || widget.obscureText
              ? IconButton(
                  icon: Icon(
                    widget.obscureText
                        ? (_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility)
                        : widget.suffixIcon,
                    color: widget.suffixIconColor ??
                        (_isFocused
                            ? AppColors.primaryColor
                            : Colors.grey[400]),
                  ),
                  onPressed: widget.obscureText
                      ? () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }
                      : widget.onSuffixIconPressed,
                )
              : null,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? AppColors.primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}

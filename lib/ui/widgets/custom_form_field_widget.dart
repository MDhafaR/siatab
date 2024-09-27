part of 'widgets.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    Key? key,
    this.controller,
    this.label,
    this.onFieldTap,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.prefixText,
    this.keyboardType,
    this.validator,
    this.contentPadding,
    this.textInputAction,
    this.readOnly = false,
    this.roundedField = true,
    this.passwordMode = false,
    this.maxLines,
    this.fillColor,
    this.enabled = true,
    this.labelStyle,
    this.style,
    this.hintStyle,
    this.child,
    this.onChange,
    this.inputFormatter,
    this.borderRadius,
    this.borderSideColor,
  }) : super(key: key);

  final Widget? child;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final bool enabled;
  final Color? fillColor;
  final String? label, hintText, prefixText;
  final TextInputType? keyboardType;
  final TextStyle? labelStyle;
  final int? maxLines;
  final VoidCallback? onFieldTap;
  final Function(String)? onChange;
  final bool passwordMode;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool roundedField;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatter;
  final double? borderRadius;
  final Color? borderSideColor;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    if (widget.label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label!,
            style: widget.labelStyle ??
                AppTheme.caption2.copyWith(
                  color: AppColor.dark,
                ),
          ),
          SizedBox(height: 8.h),
          widget.child ??
              TextFormField(
                style: widget.style ?? AppTheme.caption2.copyWith(color: AppColor.dark),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: widget.maxLines ?? 1,
                obscureText: widget.passwordMode ? _obscureText : false,
                controller: widget.controller,
                readOnly: widget.readOnly,
                enabled: widget.enabled,
                keyboardType: widget.keyboardType ??
                    (widget.passwordMode
                        ? TextInputType.visiblePassword
                        : TextInputType.text),
                textInputAction: widget.textInputAction ?? TextInputAction.next,
                decoration: InputDecoration(
                  prefixText: widget.prefixText,
                  prefixStyle: const TextStyle(color: AppColor.dark),
                  filled: !widget.enabled ? true : false,
                  fillColor: widget.fillColor,
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius ?? 8),
                    ),
                    borderSide: BorderSide(
                        color: widget.borderSideColor ?? AppColor.superLight),
                  ),
                  enabledBorder: widget.roundedField
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius ?? 8),
                          ),
                          borderSide: BorderSide(
                              color: widget.borderSideColor ?? AppColor.superLight),
                        )
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.primary),
                        ),
                  focusedBorder: widget.roundedField
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius ?? 8),
                          ),
                          borderSide: BorderSide(color: AppColor.primary),
                        )
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.primary),
                        ),
                  errorBorder: widget.roundedField
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius ?? 8),
                          ),
                          borderSide: BorderSide(color: AppColor.danger),
                        )
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.danger),
                        ),
                  focusedErrorBorder: widget.roundedField
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(widget.borderRadius ?? 8),
                          ),
                          borderSide: BorderSide(color: AppColor.danger),
                        )
                      : const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.danger),
                        ),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.passwordMode
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: _obscureText
                              ? const Icon(Icons.visibility_off,
                                  color: AppColor.primary)
                              : const Icon(Icons.visibility,
                                  color: AppColor.primary),
                        )
                      : widget.suffixIcon,
                  contentPadding: widget.contentPadding ??
                      (widget.roundedField
                          ? EdgeInsets.symmetric(
                              vertical: 8.w, horizontal: 10.w)
                          : EdgeInsets.symmetric(vertical: 14.w)),
                  hintStyle: widget.hintStyle ??
                      AppTheme.caption2.copyWith(color: AppColor.light),
                  hintText: widget.hintText,
                ),
                inputFormatters: widget.inputFormatter,
                onTap: widget.onFieldTap,
                validator: widget.validator,
                onChanged: widget.onChange,
              ),
        ],
      );
    } else {
      return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: widget.maxLines ?? 1,
        obscureText: widget.passwordMode ? _obscureText : false,
        controller: widget.controller,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType ??
            (widget.passwordMode
                ? TextInputType.visiblePassword
                : TextInputType.text),
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        decoration: InputDecoration(
          prefixText: widget.prefixText,
          filled: !widget.enabled ? true : false,
          fillColor: widget.fillColor,
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide(color: AppColor.light),
          ),
          enabledBorder: widget.roundedField
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: AppColor.light),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary),
                ),
          focusedBorder: widget.roundedField
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: AppColor.primary),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primary),
                ),
          errorBorder: widget.roundedField
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: AppColor.danger),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.danger),
                ),
          focusedErrorBorder: widget.roundedField
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: AppColor.danger),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.danger),
                ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.passwordMode
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: _obscureText
                      ? const Icon(Icons.visibility_off,
                          color: AppColor.primary)
                      : const Icon(Icons.visibility, color: AppColor.primary),
                )
              : widget.suffixIcon,
          contentPadding: widget.contentPadding ??
              (widget.roundedField
                  ? EdgeInsets.symmetric(vertical: 8.w, horizontal: 10.w)
                  : EdgeInsets.symmetric(vertical: 14.w)),
          hintStyle: AppTheme.caption2.copyWith(color: AppColor.light),
          hintText: widget.hintText,
        ),
        onTap: widget.onFieldTap,
        validator: widget.validator,
        onChanged: widget.onChange,
      );
    }
  }
}

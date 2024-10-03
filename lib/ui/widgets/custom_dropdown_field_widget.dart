part of 'widgets.dart';

class CustomDropdownField extends StatefulWidget {
  const CustomDropdownField(
      {Key? key,
      required this.value,
      required this.items,
      required this.onChange,
      required this.hint,
      this.icon,
      this.roundedField = true,
      this.validator,
      this.hintStyle,
      this.iconColor,
      this.border,
      this.label,
      this.labelStyle,
      })
      : super(key: key);

  final String? value;
  final String hint;
  final List<String>? icon;
  final List<String> items;
  final Function(String?) onChange;
  final FormFieldValidator<String>? validator;
  final bool roundedField;
  final TextStyle? hintStyle;
  final Color? iconColor;
  final BorderSide? border;
  final String? label;
  final TextStyle? labelStyle;

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.label != null)...[
          Text(
            widget.label!,
            style: widget.labelStyle ??
                AppTheme.caption2.copyWith(
                  color: AppColor.dark,
                ),
          ),
          SizedBox(height: 8.h),
        ],
        DropdownButtonFormField(
            hint: Text(widget.hint,
                style: widget.hintStyle ??
                    AppTheme.caption2.copyWith(color: AppColor.light)),
            dropdownColor: AppColor.white,
            value: widget.value,
            style: AppTheme.caption2.copyWith(color: AppColor.dark),
            icon: Icon(Icons.keyboard_arrow_down, size: 24,
                color: widget.iconColor ?? AppColor.light),
            iconSize: 20,
            validator: widget.validator,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: widget.border ?? const BorderSide(color: AppColor.superLight),
              ),
              enabledBorder: widget.roundedField
                  ? OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide:
                          widget.border ?? const BorderSide(color: AppColor.superLight),
                    )
                  : UnderlineInputBorder(
                      borderSide:
                          widget.border ?? const BorderSide(color: AppColor.primary),
                    ),
              focusedBorder: widget.roundedField
                  ? OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide:
                          widget.border ?? const BorderSide(color: AppColor.primary),
                    )
                  : UnderlineInputBorder(
                      borderSide:
                          widget.border ?? const BorderSide(color: AppColor.primary),
                    ),
              errorBorder: widget.roundedField
                  ? OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide:
                          widget.border ?? const BorderSide(color: AppColor.danger),
                    )
                  : UnderlineInputBorder(
                      borderSide:
                          widget.border ?? const BorderSide(color: AppColor.danger),
                    ),
              focusedErrorBorder: widget.roundedField
                  ? OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide:
                          widget.border ?? const BorderSide(color: AppColor.danger),
                    )
                  : UnderlineInputBorder(
                      borderSide:
                          widget.border ?? const BorderSide(color: AppColor.danger),
                    ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.w, horizontal: 10.w),
            ),
            onChanged: widget.onChange,
            items: List.generate(widget.items.length, (index) {
              return DropdownMenuItem<String>(
                value: widget.items[index],
                child: Row(
                  children: [
                    if (widget.icon != null && index < widget.icon!.length)
                      Container(
                        width: 28.r,
                        height: 28.r,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/${widget.icon![index]}.png'),
                        )),
                      ),
                    const SizedBox(width: 8),
                    Flexible(child: Text(widget.items[index], style: AppTheme.body)),
                  ],
                ),
              );
            }).toList(),
            selectedItemBuilder: (BuildContext context) {
              return widget.items.map<Widget>((String value) {
                return Text(
                    value); // This is the widget that will be shown in the field
              }).toList();
            }),
      ],
    );
  }
}

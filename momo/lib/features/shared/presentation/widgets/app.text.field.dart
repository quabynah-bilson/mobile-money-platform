import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';

enum AppTextFieldType { regular, phone, password, select, currency, card }

class AppTextField extends StatefulWidget {
  final String label;
  final bool readOnly;
  final bool showCurrency;
  final String? initialValue;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;
  final Function(String?)? onSave;
  final AppTextFieldType textFieldType;
  final Widget? suffixIcon;
  final bool autofocus;
  final bool enabled;
  final FocusNode? focusNode;
  final String tag;
  final Function()? onPrefixIconTapped;
  final String? prefixIconUrl;
  final double bottom;
  final TextInputType inputType;
  final TextInputAction action;
  final TextCapitalization capitalization;
  final int? maxLength;
  final int? maxLines;

  const AppTextField(
    this.label, {
    Key? key,
    this.initialValue,
    this.controller,
    this.onTap,
    this.focusNode,
    this.suffixIcon,
    this.onPrefixIconTapped,
    this.prefixIconUrl,
    this.onChange,
    this.onSave,
    this.maxLength,
    this.maxLines,
    this.readOnly = false,
    this.autofocus = false,
    this.showCurrency = false,
    this.enabled = true,
    this.textFieldType = AppTextFieldType.regular,
    this.tag = '',
    this.validator,
    this.bottom = 16,
    this.inputType = TextInputType.text,
    this.action = TextInputAction.done,
    this.capitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;
  final radius = 40.0;

  @override
  Widget build(BuildContext context) {
    switch (widget.textFieldType) {
      case AppTextFieldType.phone:
        return Padding(
            padding: EdgeInsets.only(bottom: widget.bottom),
            child: _phoneTextField());
      case AppTextFieldType.password:
        return Padding(
          padding: EdgeInsets.only(bottom: widget.bottom),
          child: _passwordTextField(),
        );
      case AppTextFieldType.select:
        return Padding(
          padding: EdgeInsets.only(bottom: widget.bottom),
          child: _selectTextField(),
        );
      case AppTextFieldType.currency:
        return Padding(
          padding: EdgeInsets.only(bottom: widget.bottom),
          child: _currencyTextField(),
        );
      case AppTextFieldType.card:
        return Padding(
          padding: EdgeInsets.only(bottom: widget.bottom),
          child: _cardTextField(),
        );
      default:
        return Padding(
          padding: EdgeInsets.only(bottom: widget.bottom),
          child: _regularTextField(),
        );
    }
  }

  Widget _cardTextField() => TextFormField(
        cursorColor: context.colorScheme.secondary,
        maxLength: widget.maxLength,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        initialValue: widget.initialValue,
        readOnly: widget.readOnly,
        textCapitalization: widget.capitalization,
        onTap: widget.onTap,
        validator: widget.validator,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onSaved: widget.onSave,
        onChanged: widget.onChange,
        textInputAction: widget.action,
        enabled: widget.enabled,
        // textAlign: TextAlign.center,
        inputFormatters: [
          widget.label.toString().contains('Account Number')
              ? CreditCardNumberInputFormatter()
              : widget.label.toString().contains('CVC')
                  ? CreditCardCvcInputFormatter()
                  : CreditCardExpirationDateFormatter(),
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(radius),
            ),
            counter: const SizedBox.shrink(),
            // border: InputBorder.none,
            labelStyle: TextStyle(
                color:
                    context.colorScheme.onSurface.withOpacity(kEmphasisMedium)),
            labelText: widget.label,
            hintText: widget.label.toString().contains('Account Number')
                ? '#### #### #### ####'
                : widget.label.toString().contains('CVC')
                    ? '***'
                    : 'mm/yy',
            filled: true,
            fillColor: context.colorScheme.surface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.secondary),
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(radius),
            ),
            suffixIcon: widget.suffixIcon),
      );

  Widget _currencyTextField() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              cursorColor: context.colorScheme.secondary,
              maxLength: widget.maxLength,
              controller: widget.controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              initialValue: widget.initialValue,
              textCapitalization: widget.capitalization,
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              validator: widget.validator,
              autofocus: widget.autofocus,
              focusNode: widget.focusNode,
              onSaved: widget.onSave,
              onChanged: widget.onChange,
              textInputAction: widget.action,
              enabled: widget.enabled,
              inputFormatters: [MoneyInputFormatter()],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(radius),
                ),
                counter: const SizedBox.shrink(),
                labelText: widget.label,
                labelStyle: TextStyle(
                    color: context.colorScheme.onSurface
                        .withOpacity(kEmphasisMedium)),
                filled: true,
                fillColor: context.colorScheme.surface,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: context.colorScheme.secondary),
                  borderRadius: BorderRadius.circular(radius),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(radius),
                ),
                suffixIcon: widget.suffixIcon,
              ))
        ],
      );

  Widget _selectTextField() => TextFormField(
        cursorColor: context.colorScheme.secondary,
        maxLength: widget.maxLength,
        controller: widget.controller,
        keyboardType: widget.inputType,
        initialValue: widget.initialValue,
        textCapitalization: widget.capitalization,
        readOnly: true,
        onTap: widget.onTap,
        validator: widget.validator,
        onSaved: widget.onSave,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onChanged: widget.onChange,
        textInputAction: widget.action,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(radius),
          ),
          counter: const SizedBox.shrink(),
          labelText: widget.label,
          labelStyle: TextStyle(
              color:
                  context.colorScheme.onSurface.withOpacity(kEmphasisMedium)),
          filled: true,
          fillColor: context.colorScheme.surface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.colorScheme.secondary),
            borderRadius: BorderRadius.circular(radius),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(radius),
          ),
          suffixIcon: const Icon(Icons.arrow_drop_down_circle_outlined),
          prefixIcon:
              widget.prefixIconUrl == null || widget.prefixIconUrl!.isEmpty
                  ? null
                  : SizedBox(
                      height: 30,
                      child: InkWell(
                        onTap: widget.onPrefixIconTapped ?? () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.network(
                                widget.prefixIconUrl!,
                                height: 20,
                                width: 20,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      );

  Widget _regularTextField() => TextFormField(
        cursorColor: context.colorScheme.secondary,
        maxLength: widget.maxLength,
        controller: widget.controller,
        keyboardType: widget.inputType,
        initialValue: widget.initialValue,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        validator: widget.validator,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onSaved: widget.onSave,
        onChanged: widget.onChange,
        textInputAction: widget.action,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        textCapitalization: widget.capitalization,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelStyle: TextStyle(
                color:
                    context.colorScheme.onSurface.withOpacity(kEmphasisMedium)),
            counter: const SizedBox.shrink(),
            labelText: widget.label,
            filled: true,
            fillColor: context.colorScheme.surface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.secondary),
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(radius),
            ),
            suffixIcon: widget.suffixIcon),
      );

  Widget _phoneTextField() => TextFormField(
        cursorColor: context.colorScheme.secondary,
        maxLength: widget.maxLength,
        controller: widget.controller,
        keyboardType: TextInputType.phone,
        initialValue: widget.initialValue,
        textCapitalization: widget.capitalization,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        validator: widget.validator,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        onSaved: widget.onSave,
        textInputAction: widget.action,
        enabled: widget.enabled,
        onChanged: widget.onChange,
        inputFormatters: [
          PhoneInputFormatter(),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(radius),
          ),
          counter: const SizedBox.shrink(),
          labelText: widget.label,
          labelStyle: TextStyle(
              color:
                  context.colorScheme.onSurface.withOpacity(kEmphasisMedium)),
          filled: true,
          fillColor: context.colorScheme.surface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.colorScheme.secondary),
            borderRadius: BorderRadius.circular(radius),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(radius),
          ),
          suffixIcon: widget.suffixIcon,
        ),
      );

  Widget _passwordTextField() => TextFormField(
        cursorColor: context.colorScheme.secondary,
        maxLength: widget.maxLength,
        controller: widget.controller,
        keyboardType: widget.inputType,
        initialValue: widget.initialValue,
        readOnly: widget.readOnly,
        textCapitalization: widget.capitalization,
        onTap: widget.onTap,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        validator: widget.validator,
        onSaved: widget.onSave,
        obscureText: _obscureText,
        enabled: widget.enabled,
        textInputAction: widget.action,
        onChanged: widget.onChange,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(radius),
            ),
            counter: const SizedBox.shrink(),
            labelText: widget.label,
            labelStyle: TextStyle(
                color:
                    context.colorScheme.onSurface.withOpacity(kEmphasisMedium)),
            filled: true,
            fillColor: context.colorScheme.surface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.secondary),
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(radius),
            ),
            suffixIcon: UnconstrainedBox(
              child: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: _togglePasswordVisibility),
            )),
      );

  void _togglePasswordVisibility() =>
      setState(() => _obscureText = !_obscureText);
}

class AppDropdownField extends StatelessWidget {
  final List<String> values;
  final String? current;
  final String label;
  final void Function(String) onSelected;
  final bool enabled;

  const AppDropdownField({
    Key? key,
    required this.label,
    required this.values,
    required this.onSelected,
    required this.current,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = 40.0;
    return PopupMenuButton(
      itemBuilder: (context) => values
          .map((e) => PopupMenuItem(
                onTap: () => onSelected(e),
                value: e,
                child: Text(e, style: context.theme.textTheme.subtitle1),
              ))
          .toList(),
      onSelected: onSelected,
      enableFeedback: true,
      enabled: enabled,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: TextFormField(
          cursorColor: context.colorScheme.secondary,
          controller: TextEditingController(text: current),
          readOnly: true,
          onTap: null,
          enabled: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(radius),
            ),
            counter: const SizedBox.shrink(),
            labelText: label,
            labelStyle: TextStyle(
                color:
                    context.colorScheme.onSurface.withOpacity(kEmphasisMedium)),
            filled: true,
            fillColor: context.colorScheme.surface,
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: context.colorScheme.onSurface,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.secondary),
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ),
    );
  }
}

class AppTransparentTextField extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final bool enabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool autofocus;
  final TextCapitalization capitalization;
  final TextInputAction action;
  final TextInputType inputType;
  final int? maxLines;
  final void Function(String?)? onChanged;

  const AppTransparentTextField({
    Key? key,
    required this.label,
    this.controller,
    this.enabled = true,
    this.capitalization = TextCapitalization.none,
    this.action = TextInputAction.done,
    this.inputType = TextInputType.text,
    this.style,
    this.validator,
    this.autofocus = false,
    this.maxLines,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        autofocus: autofocus,
        enabled: enabled,
        textCapitalization: capitalization,
        keyboardType: inputType,
        textInputAction: action,
        maxLines: maxLines,
        validator: validator,
        style: style,
        onChanged: onChanged,
        decoration: InputDecoration(
          enabled: enabled,
          fillColor: context.colorScheme.background,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelStyle: (style ?? context.theme.textTheme.headline4)
              ?.copyWith(color: context.theme.disabledColor),
          border: InputBorder.none,
          labelText: label,
          alignLabelWithHint: true,
        ),
      );
}

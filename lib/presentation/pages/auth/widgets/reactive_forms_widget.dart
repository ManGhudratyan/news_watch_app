import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFormsWidget extends StatefulWidget {
  const ReactiveFormsWidget({
    super.key,
    required this.title,
    required this.formControl,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
  });

  final String title;
  final FormControl<String> formControl;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<ReactiveFormsWidget> createState() => _ReactiveFormsWidgetState();
}

class _ReactiveFormsWidgetState extends State<ReactiveFormsWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControl: widget.formControl,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        labelText: widget.title,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      validationMessages: {
        ValidationMessage.required: (_) => '${widget.title} is required',
        ValidationMessage.email: (_) => 'Enter a valid email',
        ValidationMessage.minLength: (_) =>
            'Password needs to be at least 8 characters',
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileFormWidget extends StatelessWidget {
  const ProfileFormWidget({
    super.key,
    required this.title,
    required this.formControl,
    this.obscureText,
    this.keyboardType,
    this.inputFormatters,
  });

  final String title;
  final FormControl<String> formControl;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Gaps.large),
      child: ReactiveTextField<String>(
        formControl: formControl,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 238, 235, 235),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 12,
          ),
          hintText: title,
        ),
        validationMessages: {
          ValidationMessage.required: (_) => '$title is required',
          ValidationMessage.email: (_) => 'Enter a valid email',
        },
      ),
    );
  }
}

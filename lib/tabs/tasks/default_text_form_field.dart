import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  final String? hintText;
  final int? maxLines;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool isPassword;

  const DefaultTextFormField(
      {Key? key,
      this.labelText,
      this.validator,
      this.isPassword = false,
      this.hintText,
      this.maxLines = 1,
      required this.controller})
      : super(key: key);

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  bool isObsecure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,

        label: widget.labelText != null
            ? Text(
                widget.labelText!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 18, fontWeight: FontWeight.w400),
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObsecure = !isObsecure;
                  setState(() {});
                },
                icon: isObsecure
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined))
            : null,

        // counter: SizedBox()
      ),
      obscureText: isObsecure,
      maxLines: widget.maxLines,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // maxLength: 10,
    );
  }
}

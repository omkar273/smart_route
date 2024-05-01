import 'package:flutter/material.dart';
import 'package:smart_route/main.dart';

class SearchTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  const SearchTextField({
    this.onTap,
    this.hintText,
    this.labelText,
    this.onChanged,
    super.key,
    this.controller,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) Text(widget.labelText!),
        TextFormField(
          onTap: widget.onTap,
          controller: widget.controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.location_pin),
            fillColor: appPrimaryLightColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}

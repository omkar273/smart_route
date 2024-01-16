import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  const SearchTextField({
    this.hintText,
    this.labelText,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) Text(labelText!),
        TextFormField(
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.location_pin),
            fillColor: Colors.grey.withOpacity(0.15),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

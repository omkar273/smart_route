import 'package:flutter/material.dart';
import 'package:smart_route/core/utils/place_autocomplete.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    placeAutocomplete('saraf nagar');
    return const SafeArea(child: SizedBox());
  }
}

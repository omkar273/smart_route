import 'package:flutter/material.dart';
import 'package:smart_route/core/utils/place_autocomplete.dart';
import 'package:smart_route/core/utils/spacing.dart';
import 'package:smart_route/features/maps/presentation/widgets/location_tile.dart';
import 'package:smart_route/features/maps/presentation/widgets/search_text_field.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    placeAutocomplete('saraf nagar');
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SearchTextField(hintText: "Home", labelText: "From"),
              Vspace(15),
              const SearchTextField(hintText: "Destination", labelText: "TO"),
              LocationTile(
                location: "nashik",
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

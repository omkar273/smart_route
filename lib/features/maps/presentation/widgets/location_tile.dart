import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  final String location;
  final VoidCallback onTap;
  const LocationTile({super.key, required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ListTile(
        onTap: onTap,
        horizontalTitleGap: 0,
        leading: const Icon(Icons.location_pin),
        title: Text(
          location,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

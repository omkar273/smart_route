import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:smart_route/core/utils/spacing.dart';
import 'package:smart_route/features/maps/presentation/cubit/maps_cubit.dart';
import 'package:smart_route/features/maps/presentation/widgets/search.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late final TextEditingController sourceController;
  late final TextEditingController destinationController;

  @override
  void initState() {
    super.initState();
    sourceController = TextEditingController();
    destinationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: double.maxFinite,
      width: double.maxFinite,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchTextField(
              hintText: 'Source',
              labelText: 'Source',
              controller: sourceController,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return OpenStreetMapSearchAndPick(
                      buttonColor: Colors.blue,
                      buttonText: 'Set Current Location',
                      onPicked: (pickedData) {
                        context.read<MapsCubit>().setSource(pickedData);
                        print(pickedData.addressName);
                        sourceController.text =
                            pickedData.addressName.substring(0, 20);
                        Navigator.pop(context);
                      },
                    );
                  },
                ));
              },
            ),
            Vspace(10),
            SearchTextField(
              hintText: 'Destination',
              labelText: 'Destination',
              controller: destinationController,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return OpenStreetMapSearchAndPick(
                      buttonColor: Colors.blue,
                      buttonText: 'Set Current Location',
                      onPicked: (pickedData) {
                        context.read<MapsCubit>().setDestination(pickedData);
                        print(pickedData.addressName);

                        destinationController.text =
                            pickedData.addressName.substring(0, 20);
                        Navigator.pop(context);
                      },
                    );
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

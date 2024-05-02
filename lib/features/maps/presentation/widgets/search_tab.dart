import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:smart_route/core/utils/spacing.dart';
import 'package:smart_route/features/maps/presentation/cubit/maps_cubit.dart';
import 'package:smart_route/features/maps/presentation/cubit/places_data.dart';
import 'package:smart_route/features/maps/presentation/widgets/search.dart';
import 'package:smart_route/main.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key, required this.dropdownList});
  final List<Place> dropdownList;
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late final TextEditingController sourceController;
  late final TextEditingController destinationController;
  int selectedDropdownItem = 0;

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
      color: appPrimaryColor,
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
                        // print(pickedData.addressName);
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
                        // print(pickedData.addressName);

                        destinationController.text =
                            pickedData.addressName.substring(0, 20);
                        Navigator.pop(context);
                      },
                    );
                  },
                ));
              },
            ),
            Vspace(15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<int>(
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: Colors.white,
                isExpanded: true,
                padding: const EdgeInsets.all(10),
                value: selectedDropdownItem,
                items: List.generate(
                  widget.dropdownList.length,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Text(
                      widget.dropdownList[index].name,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedDropdownItem = value ?? selectedDropdownItem;
                  });
                },
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    widget.dropdownList[selectedDropdownItem].name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Vspace(20),
                  Text(widget.dropdownList[selectedDropdownItem].address),
                  // Vspace(10),
                  // const Icon(
                  //   Icons.local_hospital_outlined,
                  //   size: 50,
                  // ),

                  // Vspace(5),
                  // const Text(
                  //   '2 Km away',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                ],
              ),
            ),
            Vspace(50),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_route/core/utils/spacing.dart';
import 'package:smart_route/features/alerts/presentation/utils/make_call.dart';
import 'package:smart_route/main.dart';

class Contact {
  final String name;
  final String phone;
  Contact({required this.name, required this.phone});
}

class EmergencyContactPage extends StatelessWidget {
  static const routeName = 'Emergencycontactspage';
  static const routePath = '/Emergencycontactspage';
  EmergencyContactPage({super.key});

  final List<Contact> contactList = [
    Contact(name: 'Road Accident Emergency Service', phone: '1073'),
    Contact(name: 'POLICE', phone: '100'),
    Contact(name: 'TOURIST POLICE', phone: '02222621855'),
    Contact(name: 'FIRE', phone: '101'),
    Contact(name: 'AMBULANCE  ', phone: '102'),
    Contact(name: 'Women Helpline', phone: '1091'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Emergency Contacts',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 30 / 9,
                  mainAxisSpacing: 15,
                ),
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      makeCall(contactList[index].phone);
                    },
                    child: Card(
                      color: appPrimaryColor,
                      elevation: 5,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              contactList[index].name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Hspace(15),
                            const Icon(Icons.phone)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

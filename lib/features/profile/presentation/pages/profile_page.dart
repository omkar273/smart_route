import 'package:flutter/material.dart';
import 'package:smart_route/core/utils/spacing.dart';
import 'package:smart_route/main.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'profilepage';
  static const routePath = '/profilepage';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Card(
              color: appPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.person,
                        size: 80,
                      ),
                    ),
                    Hspace(35),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Vspace(20),
                          Row(
                            children: [
                              const Icon(Icons.email),
                              Hspace(15),
                              const Text(
                                'johndoe@gmail.com',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Vspace(10),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              Hspace(15),
                              const Text(
                                '9511',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Vspace(25),
            Card(
              color: appPrimaryLightColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.car_rental,
                      size: 32,
                    ),
                    Hspace(15),
                    const Text(
                      'Vehicle Travelled 1521Km',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Icon(
                    //   Icons.car_rental,
                    //   size: 32,
                    // ),
                  ],
                ),
              ),
            ),
            Vspace(15),
            Card(
              color: appPrimaryLightColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.car_rental,
                      size: 32,
                    ),
                    Hspace(15),
                    const Text(
                      'MH15XXXXX',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

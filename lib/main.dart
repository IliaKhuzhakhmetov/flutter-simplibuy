import 'package:e_shop_flutter/presentation/screens/application/application.dart';
import 'package:flutter/material.dart';

import 'core/di/di.dart';

void main() {
  //Initialize DI
  setUp();

  runApp(
    FutureBuilder(
      future: locator.allReady(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Application();
        } else {
          return const CircularProgressIndicator();
        }
      },
    ),
  );
}

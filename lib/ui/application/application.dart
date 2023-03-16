// ignore: overridden_fields
import 'package:e_shop_flutter/core/base/injectable_state.dart';
import 'package:e_shop_flutter/core/res/themes/primary.themes.dart';
import 'package:e_shop_flutter/ui/application/routes/application_routes.dart';
import 'package:flutter/material.dart';

import 'logic/application.cubit.dart';
import 'logic/application.state.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState
    extends InjectableState<Application, ApplicationCubit, ApplicationState> {
  @override
  Widget builder(BuildContext context, ApplicationState state) =>
      MaterialApp.router(
        routerConfig: applicationRouter,
        theme: PrimaryTheme.buildTheme(
          brightness: state.maybeWhen(
            purchasesThemeChanged: (brightness) => brightness,
            orElse: () => MediaQueryData.fromWindow(
              WidgetsBinding.instance.window,
            ).platformBrightness,
          ),
        ),
        debugShowCheckedModeBanner: false,
      );
}

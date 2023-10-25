import 'package:e_shop_flutter/core/di/di.dart';
import 'package:e_shop_flutter/core/res/themes/primary.themes.dart';
import 'package:e_shop_flutter/presentation/application/logic/application.cubit.dart';
import 'package:e_shop_flutter/presentation/application/routes/application_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/application.state.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<ApplicationCubit>(
        create: (_) => locator(),
        child: BlocBuilder<ApplicationCubit, ApplicationState>(
          builder: (context, state) => MaterialApp.router(
            routerConfig: applicationRouter,
            theme: PrimaryTheme.buildTheme(
              brightness: state.maybeWhen(
                purchasesThemeChanged: (brightness) => brightness,
                orElse: () => MediaQueryData.fromView(
                  PlatformDispatcher.instance.views.first,
                ).platformBrightness,
              ),
            ),
            debugShowCheckedModeBanner: false,
          ),
        ),
      );
}

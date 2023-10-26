import 'package:e_shop_flutter/core/di/di.dart';
import 'package:e_shop_flutter/core/res/themes/primary.themes.dart';
import 'package:e_shop_flutter/presentation/cubits/application_cubit/application.cubit.dart';
import 'package:e_shop_flutter/presentation/screens/application/routes/application_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<ApplicationCubit>(
        create: (_) => locator(),
        child: BlocBuilder<ApplicationCubit, ApplicationState>(
          builder: (context, state) => MaterialApp.router(
            routerConfig: applicationRouter,
            theme: PrimaryTheme.buildTheme(
              brightness: switch (state) {
                ApplicationBrightnessChanged() => state.brightness,
                _ => MediaQueryData.fromView(
                    PlatformDispatcher.instance.views.first,
                  ).platformBrightness,
              },
            ),
            debugShowCheckedModeBanner: false,
          ),
        ),
      );
}

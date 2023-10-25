import 'package:e_shop_flutter/core/res/assets/primary.icons.dart';
import 'package:e_shop_flutter/core/res/constants/primary.paddings.dart';
import 'package:e_shop_flutter/presentation/application/logic/application.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangeThemeButton extends StatelessWidget {
  final double size;

  const ChangeThemeButton({this.size = 32, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () => context.read<ApplicationCubit>().changeThemeMode(
            theme.brightness,
          ),
      icon: Padding(
        padding: PrimaryPaddings.standard,
        child: SvgPicture.asset(
          theme.brightness == Brightness.light
              ? PrimaryIcons.icMoon
              : PrimaryIcons.icSun,
          colorFilter: ColorFilter.mode(
            theme.iconTheme.color ?? theme.colorScheme.onBackground,
            BlendMode.srcIn,
          ),
          width: size,
          height: size,
        ),
      ),
    );
  }
}

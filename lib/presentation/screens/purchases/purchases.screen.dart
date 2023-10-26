import 'package:e_shop_flutter/core/di/di.dart';
import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/core/res/assets/primary.icons.dart';
import 'package:e_shop_flutter/core/res/constants/primary.paddings.dart';
import 'package:e_shop_flutter/core/utils/pair.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/presentation/cubits/get_all_purchases_cubit/get_all_purchases_cubit.dart';
import 'package:e_shop_flutter/presentation/screens/add_purchase/add_purchase.screen.dart';
import 'package:e_shop_flutter/presentation/screens/purchases/widgets/purchase_group_header_widget.dart';
import 'package:e_shop_flutter/presentation/screens/purchases/widgets/purchase_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:grouped_list/grouped_list.dart';

import 'widgets/change_theme_button.dart';

class PurchasesPage extends StatelessWidget {
  static const String routeName = '/purchase';

  const PurchasesPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider<GetAllPurchasesCubit>(
      create: (_) => locator()..fetch(),
      child: Scaffold(
        floatingActionButton:
            BlocBuilder<GetAllPurchasesCubit, GetAllPurchasesState>(
          builder: (context, state) => FloatingActionButton(
            onPressed: () => _onFloatingPressed(context),
            child: SvgPicture.asset(PrimaryIcons.icShoppingCart),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: PrimaryPaddings.baseHorizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Purchases',
                      style: context.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const ChangeThemeButton(),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<GetAllPurchasesCubit, GetAllPurchasesState>(
                  builder: (context, state) => switch (state) {
                    GetAllPurchasesFetched() =>
                      GroupedListView<PurchaseView, Pair<String, String>>(
                        elements: state.purchases,
                        groupBy: (element) => Pair<String, String>(
                          element.stringDate,
                          state.purchases.getSumByDate(element.stringDate),
                        ),
                        sort: false,
                        groupSeparatorBuilder: (dateAndSum) =>
                            PurchaseGroupHeaderWidget(
                          dateAndSum: dateAndSum,
                        ),
                        itemBuilder: (_, purchase) => PurchaseTile(
                          purchase: purchase,
                          onDeleted: context.read<GetAllPurchasesCubit>().fetch,
                        ),
                        stickyHeaderBackgroundColor:
                            theme.scaffoldBackgroundColor,
                        useStickyGroupSeparators: true,
                        floatingHeader: false,
                      ),
                    GetAllPurchasesFetching() => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    _ => const SizedBox(),
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onFloatingPressed(BuildContext context) async {
    final bool? result = await context.push<bool>(
      AddPurchaseScreen.routeName,
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (result ?? false) {
          context.read<GetAllPurchasesCubit>().fetch();
        }
      },
    );
  }
}

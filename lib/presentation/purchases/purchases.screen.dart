import 'package:e_shop_flutter/core/di/di.dart';
import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/core/res/assets/primary.icons.dart';
import 'package:e_shop_flutter/core/res/constants/primary.paddings.dart';
import 'package:e_shop_flutter/core/utils/pair.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/presentation/add_purchase/add_purchase.screen.dart';
import 'package:e_shop_flutter/presentation/purchases/widgets/change_theme_button.dart';
import 'package:e_shop_flutter/presentation/purchases/widgets/delete_purchase_dialog.dart';
import 'package:e_shop_flutter/presentation/purchases/widgets/purchase_group_header_widget.dart';
import 'package:e_shop_flutter/presentation/purchases/widgets/purchase_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:grouped_list/grouped_list.dart';

import 'logic/purchases.cubit.dart';
import 'logic/purchases.state.dart';

class PurchasesPage extends StatelessWidget {
  static const String routeName = '/purchase';

  const PurchasesPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider<PurchasesCubit>(
      create: (_) => locator()..fetch(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onFloatingPressed(context),
          child: SvgPicture.asset(PrimaryIcons.icShoppingCart),
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
                child: BlocBuilder<PurchasesCubit, PurchasesState>(
                  builder: (context, state) => switch (state) {
                    PurchasesFetched() =>
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
                          onLongPressed: () => _showDeleteDialog(
                            context,
                            purchases: state.purchases,
                            purchase: purchase,
                          ),
                        ),
                        stickyHeaderBackgroundColor:
                            theme.scaffoldBackgroundColor,
                        useStickyGroupSeparators: true,
                        floatingHeader: false,
                      ),
                    PurchasesFetching() => const Center(
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
          context.read<PurchasesCubit>().fetch();
        }
      },
    );
  }

  void _showDeleteDialog(
    BuildContext context, {
    required List<PurchaseView> purchases,
    required PurchaseView purchase,
  }) {
    showDialog(
      context: context,
      builder: (_) => DeletePurchaseDialog(
        purchase: purchase,
        onDeletePressed: () {
          context.read<PurchasesCubit>().delete(
                purchases: purchases,
                purchase: purchase,
              );
          Navigator.pop(context);
        },
      ),
    );
  }
}

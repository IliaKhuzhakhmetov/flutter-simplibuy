import 'package:e_shop_flutter/core/base/injectable_state.dart';
import 'package:e_shop_flutter/core/data/models/purchase_view.dart';
import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/core/res/assets/primary.icons.dart';
import 'package:e_shop_flutter/core/res/constants/primary.paddings.dart';
import 'package:e_shop_flutter/core/res/constants/primary.radiuses.dart';
import 'package:e_shop_flutter/core/utils/pair.dart';
import 'package:e_shop_flutter/ui/add_purchase/add_purchase.screen.dart';
import 'package:e_shop_flutter/ui/application/logic/application.cubit.dart';
import 'package:e_shop_flutter/ui/purchase/purchase.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:grouped_list/grouped_list.dart';
import 'logic/purchases.cubit.dart';
import 'logic/purchases.state.dart';

class PurchasesPage extends StatefulWidget {
  static const String routeName = '/purchase';

  const PurchasesPage();

  @override
  _PurchasesPageState createState() => _PurchasesPageState();
}

class _PurchasesPageState
    extends InjectableState<PurchasesPage, PurchasesCubit, PurchasesState> {
  void _showDeleteDialog(PurchaseView purchase) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              cubit.delete(purchase);
              Navigator.pop(context);
            },
            child: const Text('DELETE'),
          )
        ],
        title: Text(
          'Are you sure you want to delete the ${purchase.name.toUpperCase()}?',
        ),
      ),
    );
  }

  @override
  Widget builder(BuildContext context, PurchasesState state) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final bool? result = await context.push<bool>(
              AddPurchaseScreen.routeName,
            );

            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                if (result ?? false) {
                  cubit.fetch();
                }
              },
            );
          },
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
                    InkWell(
                      borderRadius: PrimaryRadiuses.middle,
                      onTap: () =>
                          context.read<ApplicationCubit>().changeThemeMode(
                                Theme.of(context).brightness,
                              ),
                      child: Padding(
                        padding: PrimaryPaddings.standard,
                        child: SvgPicture.asset(
                          Theme.of(context).brightness == Brightness.light
                              ? PrimaryIcons.icMoon
                              : PrimaryIcons.icSun,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).iconTheme.color!,
                            BlendMode.srcIn,
                          ),
                          width: 32,
                          height: 32,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: GroupedListView<PurchaseView, Pair<String, String>>(
                  elements: cubit.purchases,
                  groupBy: (element) => Pair<String, String>(
                    element.stringDate,
                    cubit.getSumByDate(element.stringDate),
                  ),
                  sort: false,
                  groupSeparatorBuilder: (dateAndSum) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dateAndSum.first,
                              style: context.headlineMedium,
                            ),
                            // TODO: Move to theme
                            Text(
                              '${dateAndSum.second} \$',
                              style: context.titleLarge,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                  itemBuilder: (context, PurchaseView purchase) => ListTile(
                    onLongPress: () => _showDeleteDialog(purchase),
                    onTap: () => context.push(
                      PurchaseScreen.routeName,
                      extra: purchase,
                    ),
                    title: Text(
                      purchase.name,
                      style: context.titleLarge,
                    ),
                    subtitle: Text(
                      '${purchase.normalSum} \$',
                      style: context.titleMedium,
                    ),
                  ),
                  stickyHeaderBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  useStickyGroupSeparators: true, // optional
                  floatingHeader: false, // opt// optional
                ),
              )
            ],
          ),
        ),
      );
}

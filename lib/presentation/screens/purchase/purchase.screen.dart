import 'package:e_shop_flutter/core/di/di.dart';
import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/core/res/assets/primary.icons.dart';
import 'package:e_shop_flutter/core/res/constants/primary.paddings.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/presentation/cubits/get_items_by_purchase_cubit/get_Items_by_purchase.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/items_list_tile.dart';

class PurchaseScreen extends StatelessWidget {
  static const String routeName = '/PurchaseScreen';

  final PurchaseView purchaseView;

  const PurchaseScreen(this.purchaseView, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetItemsByPurchaseCubit>(
      create: (_) => locator()..loadItems(purchaseView),
      child: Scaffold(
        body: BlocConsumer<GetItemsByPurchaseCubit, GetItemsByPurchaseState>(
          builder: (context, state) => SafeArea(
              child: switch (state) {
            GetItemsByPurchaseFetched() => Column(
                children: [
                  Padding(
                    padding: PrimaryPaddings.baseHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Text(
                            purchaseView.name,
                            style: context.headlineLarge,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: IconButton(
                            onPressed: Navigator.of(context).pop,
                            icon: SvgPicture.asset(
                              PrimaryIcons.icGoBack,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).iconTheme.color!,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Today and summary
                  Padding(
                    padding: PrimaryPaddings.baseHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          purchaseView.stringDate,
                          style: context.headlineMedium,
                        ),
                        Text(
                          '${purchaseView.normalSum} \$',
                          style: context.titleLarge,
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Divider(),

                  // List of items
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) => ItemListTile(
                        item: state.items[index],
                      ),
                    ),
                  ),
                ],
              ),
            _ => const CircularProgressIndicator(),
          }),
          listener: _listener,
        ),
      ),
    );
  }

  // TODO: Handle exceptions
  void _listener(BuildContext context, GetItemsByPurchaseState state) {
    return switch (state) {
      _ => null,
    };
  }
}

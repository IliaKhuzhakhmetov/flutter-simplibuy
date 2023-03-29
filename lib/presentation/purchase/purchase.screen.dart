import 'package:e_shop_flutter/core/base/injectable_state.dart';
import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/core/res/assets/primary.icons.dart';
import 'package:e_shop_flutter/core/res/constants/primary.paddings.dart';
import 'package:e_shop_flutter/domain/entities/item/item_view.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'logic/purchase.cubit.dart';
import 'logic/purchase.state.dart';

class PurchaseScreen extends StatefulWidget {
  static const String routeName = '/PurchaseScreen';

  final PurchaseView purchaseView;

  const PurchaseScreen(this.purchaseView, {Key? key}) : super(key: key);

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState(purchaseView);
}

class _PurchaseScreenState
    extends InjectableState<PurchaseScreen, PurchaseCubit, PurchaseState> {
  _PurchaseScreenState(PurchaseView purchaseView)
      : super.when(onCubitCreated: (cubit) => cubit.loadItems(purchaseView.id));

  @override
  Widget builder(BuildContext context, PurchaseState state) {
    return Scaffold(
      body: SafeArea(
        child: state.maybeWhen(
          itemsFetched: (purchases) {
            return Column(
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
                          widget.purchaseView.name,
                          style: context.headlineLarge,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
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
                        widget.purchaseView.stringDate,
                        style: context.headlineMedium,
                      ),
                      Text(
                        '${widget.purchaseView.normalSum} \$',
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
                    itemCount: purchases.length,
                    itemBuilder: (context, pos) {
                      final purchase = purchases[pos];
                      return ListTile(
                        trailing: Text(
                          '${purchase.count}',
                          style: context.titleLarge,
                        ),
                        title: Text(
                          purchase.name,
                          style: context.titleLarge,
                        ),
                        subtitle: Text(
                          '${purchase.normalPrice} \$',
                          style: context.titleMedium,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          orElse: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}

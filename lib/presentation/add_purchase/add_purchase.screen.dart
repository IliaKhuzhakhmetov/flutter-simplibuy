import 'package:e_shop_flutter/core/base/injectable_state.dart';
import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/core/res/assets/primary.icons.dart';
import 'package:e_shop_flutter/core/res/constants/primary.paddings.dart';
import 'package:e_shop_flutter/core/res/constants/primary.radiuses.dart';
import 'package:e_shop_flutter/core/utils/pair.dart';
import 'package:e_shop_flutter/domain/entities/item/item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router_flow/go_router_flow.dart';

import 'add_item_dialog/add_item.dialog.dart';
import 'logic/add_purchase.cubit.dart';
import 'logic/add_purchase.state.dart';

class AddPurchaseScreen extends StatefulWidget {
  static String routeName = '/add-purchase';

  const AddPurchaseScreen();

  @override
  _AddPurchaseState createState() => _AddPurchaseState();
}

class _AddPurchaseState extends InjectableState<AddPurchaseScreen,
    AddPurchaseCubit, AddPurchaseState> {
  void _showDeleteDialog(ItemView item) {
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
              cubit.deleteItem(item..count = 0);
              Navigator.pop(context);
            },
            child: const Text('DELETE'),
          )
        ],
        title: const Text('Are you sure you want to delete?'),
      ),
    );
  }

  @override
  Widget builder(BuildContext context, AddPurchaseState state) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog<Pair<String, String>>(
            context: context,
            builder: (context) => const AddItemDialog(),
          ).then(
            (itemNameAndPrice) {
              if (itemNameAndPrice != null) {
                cubit.addItem(
                  itemName: itemNameAndPrice.first,
                  itemPrice: itemNameAndPrice.second,
                );
              }
            },
          ),
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Purchase name and back button
              Padding(
                padding: PrimaryPaddings.baseHorizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Form(
                        key: cubit.formKey,
                        child: TextFormField(
                          controller: cubit.purchaseNameController,
                          keyboardType: TextInputType.text,
                          onChanged: cubit.validatePurchaseName,
                          decoration: const InputDecoration(
                            hintText: 'Enter name',
                          ),
                          validator: (value) {
                            return value?.isNotEmpty == true
                                ? null
                                : 'Please, enter the name';
                          },
                          style: context.displayMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: PrimaryRadiuses.base,
                        child: Padding(
                          padding: PrimaryPaddings.standard,
                          child: SvgPicture.asset(
                            PrimaryIcons.icGoBack,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).iconTheme.color!,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Today and total
              Padding(
                padding: PrimaryPaddings.baseHorizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => cubit.pickDate(context),
                      child: Text(cubit.date),
                    ),
                    Text(
                      '${cubit.sum} \$',
                      style: context.titleLarge,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // List of items
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.items.length,
                  itemBuilder: (context, pos) {
                    final item = cubit.items[pos];
                    return ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              // TODO: Move to cubit
                              if (--item.count > 0) {
                                cubit.updateItemCounts(item);
                              } else {
                                item.count = 1;
                                _showDeleteDialog(item);
                              }
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: PrimaryPaddings.standard,
                              child: Icon(
                                Icons.exposure_minus_1,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                          Padding(
                            padding: PrimaryPaddings.standard,
                            child: Text('${item.count}'),
                          ),
                          InkWell(
                            onTap: () {
                              item.count++;
                              cubit.updateItemCounts(item);
                            },
                            borderRadius: PrimaryRadiuses.base,
                            child: Padding(
                              padding: PrimaryPaddings.standard,
                              child: Icon(
                                Icons.plus_one,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Text(item.name),
                      subtitle: Text('${item.normalPrice} '),
                    );
                  },
                ),
              ),

              // Can Save
              if (cubit.canSave)
                Padding(
                  padding: PrimaryPaddings.standard,
                  child: InkWell(
                    onTap: () => cubit.save(),
                    borderRadius: PrimaryRadiuses.big,
                    child: const Padding(
                      padding: PrimaryPaddings.standard,
                      child: Icon(Icons.check, size: 48),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  @override
  void listener(BuildContext context, AddPurchaseState state) {
    state.maybeWhen(
      purchaseSaved: () => context.pop(true),
      orElse: () => null,
    );
  }
}

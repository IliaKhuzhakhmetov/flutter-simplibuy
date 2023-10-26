import 'package:e_shop_flutter/core/di/di.dart';
import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/core/extensions/date.extension.dart';
import 'package:e_shop_flutter/core/res/constants/primary.paddings.dart';
import 'package:e_shop_flutter/core/res/constants/primary.radiuses.dart';
import 'package:e_shop_flutter/core/utils/pair.dart';
import 'package:e_shop_flutter/core/validations/text_validations.dart';
import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:e_shop_flutter/presentation/cubits/add_purchase_cubit/add_purchase.cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/items_cubit/items_cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/pick_date_cubit/pick_date_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/validation_cubit/validation_cubit.dart';
import 'widgets/add_item.dialog.dart';

class AddPurchaseScreen extends StatefulWidget {
  static String routeName = '/add-purchase';

  const AddPurchaseScreen();

  @override
  _AddPurchaseState createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchaseScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController purchaseNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ValidationCubit>(create: (_) => locator()),
        BlocProvider<PickDateCubit>(create: (_) => locator()),
        BlocProvider<AddPurchaseCubit>(create: (_) => locator()),
        BlocProvider<ItemsCubit>(create: (_) => locator()),
      ],
      child: Scaffold(
        floatingActionButton: BlocBuilder<ItemsCubit, ItemsState>(
          builder: (context, state) => FloatingActionButton(
            onPressed: () => addItemButtonPressed(context, items: state.items),
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
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
                        key: formKey,
                        child: BlocBuilder<ValidationCubit, ValidationState>(
                          builder: (context, state) {
                            final items =
                                context.watch<ItemsCubit>().state.items;

                            return TextFormField(
                              controller: purchaseNameController,
                              keyboardType: TextInputType.text,
                              onChanged: (_) =>
                                  context.read<ValidationCubit>().validate(
                                        formKey,
                                        additionalCheck: () => items.isNotEmpty,
                                      ),
                              decoration: const InputDecoration(
                                hintText: 'Enter name',
                              ),
                              validator: TextValidations.isNotEmpty,
                              style: context.displayMedium,
                            );
                          },
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: BackButton(),
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
                    BlocBuilder<PickDateCubit, PickDateState>(
                      builder: (context, state) {
                        final initialDate =
                            context.watch<PickDateCubit>().state.date;
                        return TextButton(
                          onPressed: () => pickDate(
                            context,
                            initialDate: initialDate,
                          ),
                          child: Text(state.date.formattedDate()),
                        );
                      },
                    ),
                    BlocBuilder<ItemsCubit, ItemsState>(
                      builder: (context, state) {
                        final totalPrice = state.totalPrice.toStringAsFixed(2);

                        return Text(
                          '$totalPrice \$',
                          style: context.titleLarge,
                        );
                      },
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // List of items
              Expanded(
                child: BlocBuilder<ItemsCubit, ItemsState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (context, pos) {
                        final item = state.items[pos];
                        final cubit = context.read<ItemsCubit>();

                        return ListTile(
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  // TODO: Move to cubit
                                  if (--item.quantity > 0) {
                                    cubit.updateItemCounts(
                                      items: state.items,
                                      item: item,
                                    );
                                  } else {
                                    item.quantity = 1;

                                    showDeleteDialog(
                                      context,
                                      item: item,
                                      items: state.items,
                                    );
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
                                child: Text('${item.quantity}'),
                              ),
                              InkWell(
                                onTap: () {
                                  item.quantity++;
                                  cubit.updateItemCounts(
                                    items: state.items,
                                    item: item,
                                  );
                                },
                                borderRadius: PrimaryRadiuses.base,
                                child: Padding(
                                  padding: PrimaryPaddings.standard,
                                  child: Icon(
                                    Icons.plus_one,
                                    color: theme.iconTheme.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(item.name),
                          subtitle: Text('${item.normalPrice} '),
                        );
                      },
                    );
                  },
                ),
              ),

              // Can Save
              BlocBuilder<ValidationCubit, ValidationState>(
                builder: (context, state) {
                  final items = context.watch<ItemsCubit>().state.items;
                  final date = context.watch<PickDateCubit>().state.date;

                  return Visibility(
                    visible: state.isValid,
                    child: Padding(
                      padding: PrimaryPaddings.standard,
                      child: InkWell(
                        onTap: () => context.read<AddPurchaseCubit>().save(
                              purchaseTitle: purchaseNameController.text,
                              items: items,
                              date: date,
                            ),
                        borderRadius: PrimaryRadiuses.big,
                        child: const Padding(
                          padding: PrimaryPaddings.standard,
                          child: Icon(Icons.check, size: 48),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickDate(
    BuildContext context, {
    required DateTime initialDate,
  }) async {
    const year = 365;

    final result = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: year * 99)),
      lastDate: DateTime.now().add(const Duration(days: year * 99)),
    );

    if (result != null) {
      context.read<PickDateCubit>().changeDate(result);
    }
  }

  Future<void> addItemButtonPressed(
    BuildContext context, {
    required List<ItemView> items,
  }) async {
    final cubit = context.read<ItemsCubit>();

    final result = await showDialog<Pair<String, String>>(
      context: context,
      builder: (context) => const AddItemDialog(),
    );

    if (result != null) {
      cubit.addItem(
        items: items,
        itemName: result.first,
        itemPrice: result.second,
      );
    }
  }

  void showDeleteDialog(
    BuildContext context, {
    required ItemView item,
    required List<ItemView> items,
  }) {
    final cubit = context.read<ItemsCubit>();

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
              cubit.deleteItem(items: items, item: item);
              Navigator.pop(context);
            },
            child: const Text('DELETE'),
          )
        ],
        title: const Text('Are you sure you want to delete?'),
      ),
    );
  }
}

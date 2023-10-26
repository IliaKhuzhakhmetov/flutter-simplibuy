import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/presentation/screens/add_purchase/add_purchase.screen.dart';
import 'package:e_shop_flutter/presentation/screens/purchase/purchase.screen.dart';
import 'package:e_shop_flutter/presentation/screens/purchases/purchases.screen.dart';
import 'package:go_router_flow/go_router_flow.dart';

final applicationRouter = GoRouter(
  initialLocation: PurchasesPage.routeName,
  routes: [
    GoRoute(
      path: PurchasesPage.routeName,
      builder: (context, state) => const PurchasesPage(),
    ),
    GoRoute(
      path: AddPurchaseScreen.routeName,
      builder: (context, state) => const AddPurchaseScreen(),
    ),
    GoRoute(
      path: PurchaseScreen.routeName,
      builder: (context, state) {
        final purchase = state.extra as PurchaseView;
        return PurchaseScreen(purchase);
      },
    ),
  ],
);

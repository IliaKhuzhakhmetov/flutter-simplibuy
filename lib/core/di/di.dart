import 'package:e_shop_flutter/core/data/api/local_database/database.dart';
import 'package:e_shop_flutter/core/data/app_settings.dart';
import 'package:e_shop_flutter/core/data/repositories/items.repository.dart';
import 'package:e_shop_flutter/core/data/repositories/purchases.repository.dart';
import 'package:e_shop_flutter/core/domain/repositories/local_items.repository.dart';
import 'package:e_shop_flutter/core/domain/repositories/local_purchase.repository.dart';
import 'package:e_shop_flutter/core/domain/usecases/add_new_purchase.usecase.dart';
import 'package:e_shop_flutter/core/domain/usecases/change_app_theme_brighness.usecase.dart';
import 'package:e_shop_flutter/core/domain/usecases/delete_purchase.usecase.dart';
import 'package:e_shop_flutter/core/domain/usecases/get_purchases.usecase.dart';
import 'package:e_shop_flutter/core/domain/usecases/get_saved_brighness.usecase.dart';
import 'package:e_shop_flutter/ui/add_purchase/add_item_dialog/logic/add_item_dialog.cubit.dart';
import 'package:e_shop_flutter/ui/add_purchase/logic/add_purchase.cubit.dart';
import 'package:e_shop_flutter/ui/application/logic/application.cubit.dart';
import 'package:e_shop_flutter/ui/purchase/logic/purchase.cubit.dart';
import 'package:e_shop_flutter/ui/purchases/logic/purchases.cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'src/cubits.dart';
part 'src/usecases.dart';
part 'src/repositories.dart';

final GetIt locator = GetIt.instance;

void setUp() {
  locator.registerSingletonAsync(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => AppSettings(locator.get()));

  locator.registerSingletonAsync(() => Future.value(LocalDatabase()));

  _registerRespositories();
  _registerUsecases();
  _registerCubits();
}

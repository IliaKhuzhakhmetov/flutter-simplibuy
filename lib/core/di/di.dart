import 'package:e_shop_flutter/data/datasources/local_items.datasource.dart';
import 'package:e_shop_flutter/data/repositories/items.repository_impl.dart';
import 'package:e_shop_flutter/data/repositories/purchase.repository_impl.dart';
import 'package:e_shop_flutter/data/services/app_settings/app_settings.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';
import 'package:e_shop_flutter/domain/repositories/items.repository.dart';
import 'package:e_shop_flutter/domain/repositories/purchases.repository.dart';
import 'package:e_shop_flutter/domain/usecases/add_new_purchase.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/change_app_theme_brighness.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/delete_purchase.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/get_purchases.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/get_saved_brighness.usecase.dart';
import 'package:e_shop_flutter/presentation/add_purchase/add_item_dialog/logic/add_item_dialog.cubit.dart';
import 'package:e_shop_flutter/presentation/add_purchase/logic/add_purchase.cubit.dart';
import 'package:e_shop_flutter/presentation/application/logic/application.cubit.dart';
import 'package:e_shop_flutter/presentation/purchase/logic/purchase.cubit.dart';
import 'package:e_shop_flutter/presentation/purchases/logic/purchases.cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'src/cubits.dart';
part 'src/repositories.dart';
part 'src/usecases.dart';
part 'src/datasources.dart';

final GetIt locator = GetIt.instance;

void setUp() {
  locator.registerSingletonAsync(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => AppSettings(locator.get()));
  locator.registerSingletonAsync(() => Future.value(LocalDatabase()));

  _registerRespositories();
  _registerUsecases();
  _registerCubits();
}

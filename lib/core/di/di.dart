import 'package:e_shop_flutter/data/datasources/local_items.datasource.dart';
import 'package:e_shop_flutter/data/mappers/item_mapper.dart';
import 'package:e_shop_flutter/data/mappers/purchase_mapper.dart';
import 'package:e_shop_flutter/data/repositories/items.repository_impl.dart';
import 'package:e_shop_flutter/data/repositories/purchase.repository_impl.dart';
import 'package:e_shop_flutter/data/services/app_settings/app_settings.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';
import 'package:e_shop_flutter/domain/repositories/items.repository.dart';
import 'package:e_shop_flutter/domain/repositories/purchases.repository.dart';
import 'package:e_shop_flutter/domain/usecases/add_new_purchase.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/change_app_theme_brightness.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/delete_purchase.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/get_purchases.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/get_saved_brightness.usecase.dart';
import 'package:e_shop_flutter/presentation/cubits/add_purchase_cubit/add_purchase.cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/application_cubit/application.cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/delete_purchase_cubit/delete_purchase.cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/get_all_purchases_cubit/get_all_purchases_cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/get_items_by_purchase_cubit/get_Items_by_purchase.cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/items_cubit/items_cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/pick_date_cubit/pick_date_cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/validation_cubit/validation_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'src/cubits.dart';
part 'src/datasources.dart';
part 'src/mappers.dart';
part 'src/repositories.dart';
part 'src/usecases.dart';

final GetIt locator = GetIt.instance;

void setUp() {
  locator.registerSingletonAsync(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => AppSettings(locator.get()));
  locator.registerSingletonAsync(() => Future.value(LocalDatabase()));

  _registerMappers();
  _registerDatasources();
  _registerRepositories();
  _registerUsecases();
  _registerCubits();
}

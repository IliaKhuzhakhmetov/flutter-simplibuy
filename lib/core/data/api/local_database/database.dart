import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:e_shop_flutter/core/data/dao/items_dao/items_dao.dart';
import 'package:e_shop_flutter/core/data/dao/purchase_dao/purchase_dao.dart';
import 'package:e_shop_flutter/core/data/models/item.dart';
import 'package:e_shop_flutter/core/data/models/purchase.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Purchase, Item])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  PurchaseDao get purchaseDao => PurchaseDao(this);
  ItemsDao get itemsDao => ItemsDao(this);

  @override
  int get schemaVersion => 1;

  @override
  StreamQueryUpdateRules get streamUpdateRules => StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTable(
              purchase,
              limitUpdateKind: UpdateKind.delete,
            ),
            result: [
              TableUpdate.onTable(item, kind: UpdateKind.delete),
            ],
          )
        ],
      );
}

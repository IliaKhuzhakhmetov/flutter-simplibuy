import 'package:drift/drift.dart';
import 'package:e_shop_flutter/core/base/mapper.dart';
import 'package:e_shop_flutter/data/services/local_database/dao/purchase_dao/purchase_dao.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/repositories/purchases.repository.dart';

class PurchasesRepositoryImpl extends PurchasesRepository {
  final PurchaseDao _purchaseDao;
  final Mapper<PurchaseView, PurchaseTableData> _purchaseMapper;

  PurchasesRepositoryImpl({
    required Mapper<PurchaseView, PurchaseTableData> purchaseMapper,
    required PurchaseDao dao,
  })  : _purchaseMapper = purchaseMapper,
        _purchaseDao = dao;

  @override
  Future<int> addPurchase(PurchaseView purchase) => _purchaseDao.insert(
        _purchaseMapper.toModel(purchase).copyWith(
              id: const Value(null),
            ),
      );

  @override
  Future<List<PurchaseView>> getPurchases() async {
    final result = await _purchaseDao.getPurchases();

    return result.map((model) => _purchaseMapper.fromModel(model)).toList();
  }

  @override
  Future deletePurchase(PurchaseView purchase) => _purchaseDao.deletePurchase(
        _purchaseMapper.toModel(purchase),
      );
}

import 'package:e_shop_flutter/core/data/api/local_database/database.dart';
import 'package:e_shop_flutter/core/data/dao/purchase_dao/purchase_dao.dart';
import 'package:e_shop_flutter/core/data/repositories/purchases.repository.dart';

class LocalPurchasesRepository extends PurchasesRepository {
  final PurchaseDao _purchaseDao;

  LocalPurchasesRepository({required PurchaseDao dao}) : _purchaseDao = dao;

  @override
  Future<int> addPurchase(PurchaseData data) => _purchaseDao.insert(data);

  @override
  Future<List<PurchaseData>> getPurchases() => _purchaseDao.getPurchases();

  @override
  Future deletePurchase(PurchaseData purchaseData) =>
      _purchaseDao.deletePurchase(purchaseData);
}

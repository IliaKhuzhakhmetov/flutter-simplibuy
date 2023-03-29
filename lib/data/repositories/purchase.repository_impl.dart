import 'package:e_shop_flutter/data/services/local_database/dao/purchase_dao/purchase_dao.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';
import 'package:e_shop_flutter/domain/repositories/purchases.repository.dart';

class PurchasesRepositoryImpl extends PurchasesRepository {
  final PurchaseDao _purchaseDao;

  PurchasesRepositoryImpl({required PurchaseDao dao}) : _purchaseDao = dao;

  @override
  Future<int> addPurchase(PurchaseData data) => _purchaseDao.insert(data);

  @override
  Future<List<PurchaseData>> getPurchases() => _purchaseDao.getPurchases();

  @override
  Future deletePurchase(PurchaseData purchaseData) =>
      _purchaseDao.deletePurchase(purchaseData);
}

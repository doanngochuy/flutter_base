import 'package:EMO/common/di/injector.dart';

import '../entities/entities.dart';
import '../remote/remote.dart';

abstract class WithdrawStore {
  static WithdrawStore get to => AppInjector.injector<WithdrawStore>();

  List<String> get withdrawMethods;

  List<String> get bankNames;

  Future<ResponseSync<Withdraw>> getWithdraws({
    int pageSize,
    int page,
    String sort,
    String order,
  });

  Future postWithdraws(Map<String, dynamic> request);
}

class WithdrawStoreImpl implements WithdrawStore {
  @override
  List<String> get withdrawMethods => const ['Ngân hàng', 'MOMO', 'ZaloPay', 'USDT'];

  @override
  List<String> get bankNames => const [
        'Vietcombank',
        'Vietinbank',
        'Techcombank',
        'BIDV',
        'ACB',
        'Agribank',
        'Sacombank',
        'MBBank',
        'VPBank',
        'Eximbank',
        'Oceanbank',
        'TPBank',
        'SHB',
        'SeABank',
        'Bac A Bank',
        'HDBank',
        'LienVietPostBank',
        'VIB',
        'PVcomBank',
      ];

  @override
  Future<ResponseSync<Withdraw>> getWithdraws({
    int pageSize = 10,
    int page = 1,
    String sort = "id",
    String order = "desc",
  }) =>
      ApiService.create().getWithdraws(
        pageSize: pageSize,
        page: page,
        sort: sort,
        order: order,
      );

  @override
  Future postWithdraws(Map<String, dynamic> request) => ApiService.create().postWithdraws(request);
}

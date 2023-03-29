import 'package:EMO/common/di/injector.dart';

import '../entities/entities.dart';
import '../remote/remote.dart';

abstract class WithdrawStore {
  static WithdrawStore get to => AppInjector.injector<WithdrawStore>();

  Future<ResponseSync<Withdraw>> getWithdraws({
    int pageSize,
    int page,
    String sort,
    String order,
  });
}

class WithdrawStoreImpl implements WithdrawStore {
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
}

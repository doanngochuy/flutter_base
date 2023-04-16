import 'package:EMO/common/store/store.dart';
import 'package:get/get.dart';

import 'state.dart';

class CreateWithdrawController extends GetxController {
  static CreateWithdrawController get to => Get.find();

  final state = CreateWithdrawState();

  CreateWithdrawController();

  void initState() {}

  Future createWithdraw({
    required int money,
    required String account,
    required int numberAccount,
    required String withdrawMethod,
    required String bankName,
    required String description,
  }) async {
    final body = {
      "description": description,
      "money": money,
      "withdraw_method": withdrawMethod,
      "bank_name": bankName,
      "number_account": numberAccount,
      "account_name": account,
    };
    await WithdrawStore.to.postWithdraws(body);
  }
}

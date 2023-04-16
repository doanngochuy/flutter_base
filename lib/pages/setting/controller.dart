import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/theme/theme.dart';
import 'package:EMO/common/values/values.dart';
import 'package:EMO/pages/setting/state.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find<SettingController>();
  final state = SettingState();

  SettingController();

  @override
  Future<void> onReady() async {
    super.onReady();
    await AppConfigureStore.to.syncData();
  }

  Future<bool> updateToRemoteDatabase<T>(String key, T value) async {
    try {
      const result = true; //Call Api update setting
      return result;
    } catch (e) {
      CustomSnackBar.error(title: "Error".tr, message: e.toString());
      return false;
    }
  }

  static const _mappingData = {
    AppStorage.prefActiveQrCode: "QrCodeEnable",
    AppStorage.prefNameAcc: "AccName",
    AppStorage.prefNumberAcc: "AccNumber",
    AppStorage.prefNameBank: "BankName",
  };

  Future<bool> handleUpdateData<T>(String key, T value) async {
    final k = _mappingData[key];

    if (k != null) return updateToRemoteDatabase(k, value);

    return true;
  }

  Future<void> setAttribute<T>(String key, T value) async {
    final isSuccess = await handleUpdateData<T>(key, value);

    isSuccess
        ? AppConfigureStore.to.setAttribute<T>(key, value)
        : CustomSnackBar.error(title: S.current.Loi, message: S.current.Cap_nhat_that_bai);
  }
}

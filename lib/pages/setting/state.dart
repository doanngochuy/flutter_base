import 'package:get/get.dart';
import 'package:flutter_base/common/values/print_model.dart';
import 'package:flutter_base/pages/pages.dart';

class SettingState {
  final RxList<PrintCodeMobile> tempalteKeys =
      RxList<PrintCodeMobile>(const []);
  final Rx<TemplateTypeWeb> selectedValue =
      Rx<TemplateTypeWeb>(TemplateTypeWeb.donHang5880);
  final RxList<dynamic> tempalteKeyWeb = RxList<dynamic>(const []);
}

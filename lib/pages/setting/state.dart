import 'package:get/get.dart';
import 'package:EMO/pages/pages.dart';

class SettingState {
  final Rx<TemplateTypeWeb> selectedValue =
      Rx<TemplateTypeWeb>(TemplateTypeWeb.donHang5880);
  final RxList<dynamic> tempalteKeyWeb = RxList<dynamic>(const []);
}

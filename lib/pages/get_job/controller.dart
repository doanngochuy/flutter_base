import 'package:EMO/common/store/job_store.dart';
import 'package:get/get.dart';

import 'state.dart';

class GetJobController extends GetxController {
  static GetJobController get to => Get.find();

  final state = GetJobState();

  GetJobController();

  Future getJob() => JobStore.to.getCurrentJob().then(state.setCurrentJob);

  Future cancelJob() => JobStore.to.cancelJob().then((_) => state.removeJob());
}

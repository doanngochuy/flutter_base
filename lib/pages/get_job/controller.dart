import 'package:flutter_base/common/store/job_store.dart';
import 'package:get/get.dart';

import 'state.dart';

class GetJobController extends GetxController {
  static GetJobController get to => Get.find();

  final state = GetJobState();

  GetJobController();

  Future getJob() async {
    final response = await JobStore.to.getCurrentJob();
    state.setCurrentJob(response);
  }
}

import 'package:get/get.dart';

import '../../common/entities/entities.dart';

class GetJobState {
  final Rx<Job?> _job = Rx<Job?>(null);

  Job? get job => _job.value;

  final RxnInt _currentId = RxnInt(null);

  int? get currentId => _currentId.value;

  void setCurrentJob(CurrentJobResponse value) {
    print("setCurrentJob ${value.currentId} -  ${value.job?.id}");
    _currentId.value = value.currentId;
    _job.value = value.job;
  }
}

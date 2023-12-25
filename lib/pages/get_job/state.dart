import 'package:get/get.dart';

import '../../common/entities/entities.dart';

class GetJobState {
  final Rx<Job?> _job = Rx<Job?>(const Job());

  Job? get job => _job.value;

  final RxnInt _currentId = RxnInt(null);

  int? get currentId => _currentId.value;

  void setCurrentJob(CurrentJobResponse value) {
    _currentId.value = value.currentId;
    _job.value = value.job;
  }

  void removeJob() {
    _job.value = const Job();
    _currentId.value = null;
  }
}

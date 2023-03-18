import 'package:get/get.dart';

import '../../common/entities/entities.dart';

class GetJobState {
  Job? job;
  StartJobResponse? startJobResponse;

  final keyWordHintId = 'search-key-hint';

  final RxnInt _currentId = RxnInt(null);

  int? get currentId => _currentId.value;

  final RxBool _isStartJob = RxBool(false);

  final RxBool _isFinishJob = RxBool(false);

  bool get isStartJob => _isStartJob.value;

  bool get isFinishJob => _isFinishJob.value && _isStartJob.value;

  Stream<bool> get isFinishJobStream => _isFinishJob.stream;

  setIsStartJob(bool value) => _isStartJob.value = value;

  setIsFinishJob(bool value) => _isFinishJob.value = value;

}

enum Event {
  startJob,
  finishJob,
}

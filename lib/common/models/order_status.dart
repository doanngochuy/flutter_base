import 'package:json_annotation/json_annotation.dart';
import 'package:EMO/common/generated/l10n.dart';

enum JobState {
  @JsonValue(1)
  pending,
  @JsonValue(2)
  done,
  @JsonValue(3)
  cancel;

  const JobState();

  String get getNameStatus {
    switch (this) {
      case pending:
        return S.current.Dang_xu_ly;
      case done:
        return S.current.Hoan_thanh;
      case cancel:
        return S.current.Huy;
    }
  }

  int get getValueStatus {
    switch (this) {
      case pending:
        return 1;
      case done:
        return 2;
      case cancel:
        return 3;
    }
  }

  static List<JobState> get allStatus => [
        JobState.done,
        JobState.cancel,
        JobState.pending,
      ];
}

import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Job {
  final int id;
  final String keyWord;
  final String image;
  final int total;
  final int count;
  final String url;
  final String keyPage;
  final String valuePage;
  final int time;
  // final List<UserJob> users;
  // final Current current;

  const Job({
    this.id = -1,
    this.keyWord = "",
    this.image = "",
    this.total = 0,
    this.count = 0,
    this.url = "",
    this.keyPage = "",
    this.valuePage = "",
    this.time = 0,
    // this.users = const [],
    // this.current = const Current(),
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);

  static Job cloneInstance(Job job) {
    return Job.fromJson(job.toJson());
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CurrentJobResponse {
  final int currentId;
  final Job? job;

  const CurrentJobResponse({
    this.currentId = -1,
    this.job,
  });

  factory CurrentJobResponse.fromJson(Map<String, dynamic> json) => _$CurrentJobResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentJobResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class StartJobResponse {
  final String token;
  final String key;

  const StartJobResponse({
    this.token = "",
    this.key = "",
  });

  factory StartJobResponse.fromJson(Map<String, dynamic> json) => _$StartJobResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StartJobResponseToJson(this);
}
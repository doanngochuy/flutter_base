import 'package:json_annotation/json_annotation.dart';

/// e.g. "[[26333],[27095]]" ---> [26333,27095]
class NumbersConverter implements JsonConverter<List<int>, String> {
  @override
  List<int> fromJson(String json) {
    /// use regex to split string into list of numbers
    final regex = RegExp(r'\d+');
    final matches = regex.allMatches(json);
    final numbers = matches.map((e) => int.parse(e.group(0)!)).toList();
    return numbers;
  }

  @override
  String toJson(List<int> object) => object.toString();

  const NumbersConverter();
}

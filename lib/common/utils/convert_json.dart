@Deprecated(
  "It will delete in the future",
)
String convertJsonToQueryParams(
    {required String domain, required Map<String, String> json}) {
  String query = '';
  json.forEach((key, value) {
    query += '$key=$value&';
  });
  return '$domain?$query';
}

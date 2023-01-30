import 'package:intl/intl.dart';

String truncateNumberToString(dynamic number) {
  final f = NumberFormat("###,###.###", "tr_TR");
  return f.format(number).replaceAll(',', '*').replaceAll('.', ',').replaceAll('*', '.');
}

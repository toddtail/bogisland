import 'package:intl/intl.dart';

String timeTransfer(int timestamp) {
  var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dt).toString();

}
import 'package:easy_localization/easy_localization.dart';

String formatDate({required DateTime date, required format}) {
  final DateFormat formatter = DateFormat(format);
  return formatter.format(date);
}

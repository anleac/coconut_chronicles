class IoHelper {
  static int? saveDateToFile(DateTime? dateTime) => dateTime?.millisecondsSinceEpoch;
  static DateTime? readDateFromSave(int? epoch) => epoch == null ? null : DateTime.fromMillisecondsSinceEpoch(epoch);
}

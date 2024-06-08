import 'package:coconut_chronicles/constants/storage_constants.dart';

class HiddenTextHelper {
  static String hiddenText(String text) =>
      StorageConstants.hiddenSegmentStartTag + text + StorageConstants.hiddenSegmentEndTag;
}

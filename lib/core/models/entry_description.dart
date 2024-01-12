// A helper to store the description of an entry and process potentially hidden segments.
import 'package:coconut_chronicles/core/helpers/entry_helper.dart';
import 'package:coconut_chronicles/core/storage/hidden_segment.dart';

class EntryDescription {
  final String _rawDescription;

  late final String _sanitisedDescription;
  late final List<HiddenSegment> _hiddenSegments;

  late String _safeDescription;

  String get description => _safeDescription;
  bool _isEncrypted;

  EntryDescription(this._rawDescription, this._isEncrypted) {
    var (sanitisedDescription, hiddenSegments) = EntryHelper.processParagraph(_rawDescription);
    _sanitisedDescription = sanitisedDescription;
    _hiddenSegments = hiddenSegments;

    _safeDescription = _isEncrypted ? _sanitisedDescription : _rawDescription;
  }

  void decrypt(String password) {
    if (!_isEncrypted) return;

    _safeDescription = EntryHelper.decrypt(_sanitisedDescription, password, _hiddenSegments);
  }
}

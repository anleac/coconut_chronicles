class HiddenSegment {
  final String _segment;
  final int _index;

  bool _decrypted = false;
  String _decryptedSegment = '';

  String get segment => _decrypted ? _decryptedSegment : _segment;
  int get index => _index;

  HiddenSegment(this._segment, this._index);

  @override
  bool operator ==(Object other) {
    if (other is HiddenSegment) {
      return _segment == other._segment && _index == other._index;
    }
    return false;
  }

  @override
  int get hashCode => _segment.hashCode ^ _index.hashCode;

  @override
  String toString() {
    return 'HiddenSegment{segment: $_segment, index: $_index}';
  }
}

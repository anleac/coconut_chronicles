class HiddenSegment {
  final String segment;
  final int index;

  HiddenSegment(this.segment, this.index);

  @override
  bool operator ==(Object other) {
    if (other is HiddenSegment) {
      return segment == other.segment && index == other.index;
    }
    return false;
  }

  @override
  int get hashCode => segment.hashCode ^ index.hashCode;

  @override
  String toString() {
    return 'HiddenSegment{segment: $segment, index: $index}';
  }
}

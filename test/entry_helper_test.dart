import 'package:coconut_chronicles/constants/storage_constants.dart';
import 'package:coconut_chronicles/core/helpers/entry_helper.dart';
import 'package:coconut_chronicles/core/storage/hidden_segment.dart';
import 'package:flutter_test/flutter_test.dart';

String hiddenText(String text) => StorageConstants.hiddenSegmentStartTag + text + StorageConstants.hiddenSegmentEndTag;

void main() {
  group('EntryHelper.processParagraph', () {
    test('should return the same paragraph and an empty list if no hidden segments', () {
      String paragraph = 'This is a normal paragraph.';
      var (sanitisedSegment, hiddenSegments) = EntryHelper.processParagraph(paragraph);

      expect(sanitisedSegment, paragraph);
      expect(hiddenSegments, isEmpty);
    });

    // Define a test case for a paragraph with one hidden segment at the beginning
    test('should return a sanitised paragraph and a list with one hidden segment if hidden at the beginning', () {
      String paragraph = '${hiddenText('This is a hidden segment.')}This is a normal segment.';
      var (sanitisedSegment, hiddenSegments) = EntryHelper.processParagraph(paragraph);

      expect(sanitisedSegment, 'This is a normal segment.');
      expect(hiddenSegments.first, HiddenSegment('This is a hidden segment.', 0));
    });

    // Define a test case for a paragraph with one hidden segment at the end
    test('should return a sanitised paragraph and a list with one hidden segment if hidden at the end', () {
      String paragraph = 'This is a normal segment.${hiddenText('This is a hidden segment.')}';

      var (sanitisedSegment, hiddenSegments) = EntryHelper.processParagraph(paragraph);

      expect(sanitisedSegment, 'This is a normal segment.');
      expect(hiddenSegments.first, HiddenSegment('This is a hidden segment.', 25));
    });

    // Define a test case for a paragraph with one hidden segment in the middle
    test('should return a sanitised paragraph and a list with one hidden segment if hidden in the middle', () {
      String paragraph =
          'This is a normal segment.${hiddenText('This is a hidden segment.')}This is another normal segment.';

      var (sanitisedSegment, hiddenSegments) = EntryHelper.processParagraph(paragraph);

      expect(sanitisedSegment, 'This is a normal segment.This is another normal segment.');
      expect(hiddenSegments.first, HiddenSegment('This is a hidden segment.', 25));
    });

    // Define a test case for a paragraph with multiple hidden segments
    test('should return a sanitised paragraph and a list with multiple hidden segments if multiple hidden', () {
      String paragraph =
          '${hiddenText('This is a hidden segment.')}This is a normal segment.${hiddenText('This is another hidden segment.')}This is another normal segment.${hiddenText('This is the last hidden segment.')}';

      var (sanitisedSegment, hiddenSegments) = EntryHelper.processParagraph(paragraph);

      expect(sanitisedSegment, 'This is a normal segment.This is another normal segment.');
      expect(hiddenSegments, [
        HiddenSegment('This is a hidden segment.', 0),
        HiddenSegment('This is another hidden segment.', 25),
        HiddenSegment('This is the last hidden segment.', 56),
      ]);
    });
  });
}

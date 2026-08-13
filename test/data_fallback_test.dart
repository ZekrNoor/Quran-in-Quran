import 'package:flutter_test/flutter_test.dart';
import 'package:quran_in_quran/reader/quran_data_loader.dart';

void main() {
  test('normalizes quran.com page payload into app-compatible verse structure', () {
    final payload = {
      'verses': [
        {
          'id': 1,
          'verse_number': 1,
          'verse_key': '1:1',
          'page_number': 1,
          'words': [
            {
              'id': 1,
              'position': 1,
              'line_number': 2,
              'text': 'ب',
              'code_v1': 'ب',
              'verse_id': 1,
              'verse_key': '1:1',
            },
          ],
        },
      ],
    };

    final normalized = QuranDataLoader.normalizePagePayload(payload);

    expect(normalized['verses'], isNotEmpty);
    expect(normalized['verses'][0]['chapter_id'], 1);
    expect(normalized['verses'][0]['words'][0]['code_v2'], 'ب');
    expect(normalized['verses'][0]['words'][0]['line_number'], 2);
  });
}

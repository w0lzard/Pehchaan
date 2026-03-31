import 'package:flutter_test/flutter_test.dart';
import 'package:pehchaan/features/scanner/domain/detected_id.dart';
import 'package:pehchaan/features/scanner/domain/id_extractor.dart';

void main() {
  test('Aadhaar with spaces', () {
    final id = extractId('Name\n1234 5678 9012\nIndia')!;
    expect(id.type, IdType.aadhaar);
    expect(id.toString(), 'Aadhaar: 1234 5678 9012');
  });

  test('PAN: clean', () {
    expect(extractId('Permanent Account Number ABCDE1234F')!.toString(),
        'PAN: ABCDE1234F');
  });

  test('PAN: letter O in a letter slot is kept (old bug)', () {
    expect(extractId('NOPQR1234S')!.toString(), 'PAN: NOPQR1234S');
  });

  test('PAN: OCR 0/O swaps are fixed per slot', () {
    // 0 in a letter slot, O in a digit slot
    expect(extractId('AB0DE12O4F')!.toString(), 'PAN: ABODE1204F');
  });

  test('10-digit phone number is not a PAN', () {
    expect(extractId('9876543210'), isNull);
  });

  test('Voter ID', () {
    expect(extractId('EPIC ABC1234567')!.type, IdType.voter);
  });

  test('DL is normalized', () {
    expect(extractDrivingLicense('DL WB-37 20140194444'), 'WB3720140194444');
  });

  test('no match returns null', () {
    expect(extractId('hello world'), isNull);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pehchaan/features/scanner/data/scanner_repository.dart';
import 'package:pehchaan/features/scanner/domain/detected_id.dart';
import 'package:pehchaan/features/scanner/presentation/cubit/scanner_cubit.dart';
import 'package:pehchaan/features/scanner/presentation/cubit/scanner_intent.dart';
import 'package:pehchaan/features/scanner/presentation/cubit/scanner_state.dart';

class _FakeRepo implements ScannerRepository {
  _FakeRepo({this.path = '/img.png', this.text = '', this.fail = false});
  final String? path;
  final String text;
  final bool fail;

  @override
  Future<String?> pickImage(ImageOrigin origin) async => path;
  @override
  Future<String> recognizeText(String imagePath) async =>
      fail ? throw Exception('boom') : text;
  @override
  Future<void> dispose() async {}
}

void main() {
  blocTest<ScannerCubit, ScannerState>(
    'pick -> scanning -> done with detected ID',
    build: () => ScannerCubit(_FakeRepo(text: '1234 5678 9012')),
    act: (c) => c.processIntent(const PickImageIntent(ImageOrigin.gallery)),
    expect: () => [
      const ScannerState(status: ScanStatus.scanning, imagePath: '/img.png'),
      const ScannerState(
        status: ScanStatus.done,
        imagePath: '/img.png',
        scannedText: '1234 5678 9012',
        detectedId: DetectedId(IdType.aadhaar, '1234 5678 9012'),
      ),
    ],
  );

  blocTest<ScannerCubit, ScannerState>(
    'cancelled pick emits nothing',
    build: () => ScannerCubit(_FakeRepo(path: null)),
    act: (c) => c.processIntent(const PickImageIntent(ImageOrigin.camera)),
    expect: () => <ScannerState>[],
  );

  blocTest<ScannerCubit, ScannerState>(
    'OCR error -> failure, then reset -> initial',
    build: () => ScannerCubit(_FakeRepo(fail: true)),
    act: (c) async {
      await c.processIntent(const PickImageIntent(ImageOrigin.camera));
      await c.processIntent(const ResetIntent());
    },
    expect: () => [
      const ScannerState(status: ScanStatus.scanning, imagePath: '/img.png'),
      const ScannerState(status: ScanStatus.failure, imagePath: '/img.png'),
      const ScannerState(),
    ],
  );
}

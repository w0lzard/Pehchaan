import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logging/logger.dart';
import '../../data/scanner_repository.dart';
import '../../domain/id_extractor.dart';
import 'scanner_intent.dart';
import 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit(this._repository) : super(const ScannerState());

  final ScannerRepository _repository;

  /// MVI entry point: the view sends intents, never calls logic directly.
  Future<void> processIntent(ScannerIntent intent) async {
    switch (intent) {
      case PickImageIntent(:final origin):
        await _pickAndScan(origin);
      case ResetIntent():
        emit(const ScannerState());
    }
  }

  Future<void> _pickAndScan(ImageOrigin origin) async {
    final path = await _repository.pickImage(origin);
    if (path == null) return;

    emit(ScannerState(status: ScanStatus.scanning, imagePath: path));
    try {
      final text = await _repository.recognizeText(path);
      logger.w("Scanned Text: $text");
      emit(
        ScannerState(
          status: ScanStatus.done,
          imagePath: path,
          scannedText: text,
          detectedId: extractId(text),
        ),
      );
    } catch (e, st) {
      logger.e("OCR failed", error: e, stackTrace: st);
      emit(ScannerState(status: ScanStatus.failure, imagePath: path));
    }
  }

  @override
  Future<void> close() async {
    await _repository.dispose();
    return super.close();
  }
}

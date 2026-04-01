import 'package:equatable/equatable.dart';

import '../../domain/detected_id.dart';

enum ScanStatus { idle, scanning, done, failure }

/// Single immutable model the view renders.
class ScannerState extends Equatable {
  const ScannerState({
    this.status = ScanStatus.idle,
    this.imagePath,
    this.scannedText = '',
    this.detectedId,
  });

  final ScanStatus status;
  final String? imagePath;
  final String scannedText;
  final DetectedId? detectedId;

  @override
  List<Object?> get props => [status, imagePath, scannedText, detectedId];
}

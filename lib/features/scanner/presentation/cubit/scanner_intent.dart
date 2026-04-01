import '../../data/scanner_repository.dart';

/// Everything the user can ask the scanner screen to do.
sealed class ScannerIntent {
  const ScannerIntent();
}

class PickImageIntent extends ScannerIntent {
  const PickImageIntent(this.origin);
  final ImageOrigin origin;
}

class ResetIntent extends ScannerIntent {
  const ResetIntent();
}

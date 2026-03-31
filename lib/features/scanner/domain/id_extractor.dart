import 'detected_id.dart';

/// Pure OCR-text -> ID matching. No Flutter or platform dependencies.
DetectedId? extractId(String text) {
  final aadhaar = RegExp(
    r"\b\d{4}\s\d{4}\s\d{4}\b|\b\d{12}\b",
  ).firstMatch(text);
  if (aadhaar != null) return DetectedId(IdType.aadhaar, aadhaar.group(0)!);

  final pan = _extractPan(text);
  if (pan != null) return DetectedId(IdType.pan, pan);

  final voter = RegExp(r"\b[A-Z]{3}[0-9]{7}\b").firstMatch(text);
  if (voter != null) return DetectedId(IdType.voter, voter.group(0)!);

  final dl = extractDrivingLicense(text);
  if (dl != null) return DetectedId(IdType.drivingLicense, dl);

  return null;
}

/// Handles WB-37..., WB37..., WB-3720..., WB37 2014... and returns it
/// without dashes/spaces, e.g. WB3720140194444.
String? extractDrivingLicense(String text) {
  final normalized = text.replaceAll("O", "0"); // common OCR slip
  final match = RegExp(
    r"\b[A-Z]{2}[-\s]?[0-9]{2,4}[-\s]?[0-9]{6,12}\b",
  ).firstMatch(normalized);
  return match?.group(0)!.replaceAll(RegExp(r"[-\s]"), "");
}

/// PAN is AAAAA9999A. OCR confuses 0/O and 1/I, so fix each slot by position
/// (letter slots: 0->O, 1->I; digit slots: O->0, I->1) before strict matching.
String? _extractPan(String text) {
  for (final m in RegExp(r"\b[A-Z0-9]{10}\b").allMatches(text)) {
    final raw = m.group(0)!;
    if (!raw.contains(RegExp(r"[A-Z]"))) continue; // all digits: not a PAN
    final fixed = [
      for (var i = 0; i < raw.length; i++)
        _isLetterSlot(i) ? _toLetter(raw[i]) : _toDigit(raw[i]),
    ].join();
    if (RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]$").hasMatch(fixed)) return fixed;
  }
  return null;
}

bool _isLetterSlot(int i) => i < 5 || i == 9;
String _toLetter(String c) => switch (c) { '0' => 'O', '1' => 'I', _ => c };
String _toDigit(String c) => switch (c) { 'O' => '0', 'I' => '1', _ => c };

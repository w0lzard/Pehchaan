import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

enum ImageOrigin { camera, gallery }

abstract interface class ScannerRepository {
  /// Returns the picked image path, or null if the user cancelled.
  Future<String?> pickImage(ImageOrigin origin);
  Future<String> recognizeText(String imagePath);
  Future<void> dispose();
}

class MlKitScannerRepository implements ScannerRepository {
  final _picker = ImagePicker();
  final _recognizer = TextRecognizer();

  @override
  Future<String?> pickImage(ImageOrigin origin) async {
    final file = await _picker.pickImage(
      source: switch (origin) {
        ImageOrigin.camera => ImageSource.camera,
        ImageOrigin.gallery => ImageSource.gallery,
      },
    );
    return file?.path;
  }

  @override
  Future<String> recognizeText(String imagePath) async {
    final result = await _recognizer.processImage(
      InputImage.fromFilePath(imagePath),
    );
    return result.text;
  }

  @override
  Future<void> dispose() => _recognizer.close();
}

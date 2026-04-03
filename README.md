# 🪪 Pehchaan

A Flutter app that scans Aadhaar, PAN, Voter ID, and Driving License numbers from images using **Google ML Kit OCR**.  
You can capture an image using the **camera** or select one from the **gallery**, and the app extracts the ID number automatically.

---

## ✨ Features
- 📸 Capture image from **camera**  
- 🖼️ Pick image from **gallery**  
- 🔍 Extracts text using **Google ML Kit Text Recognition**  
- 🧾 Detects and validates:
  - Aadhaar (12 digits / space-separated format)
  - PAN (ABCDE1234F)
  - Voter ID (ABC1234567)
  - Driving License (handles multiple Indian formats like `WB-37...`, `WB3720...`, `WB37 2014...`)  
- 🎨 Clean UI with Material design  
- 🧹 Normalizes extracted IDs (removes spaces/dashes in DL, keeps Aadhaar spacing intact)

---

## 🛠️ Tech Stack
- [Flutter](https://flutter.dev) (cross-platform framework)
- [google_mlkit_text_recognition](https://pub.dev/packages/google_mlkit_text_recognition) (OCR engine)
- [image_picker](https://pub.dev/packages/image_picker) (camera/gallery integration)

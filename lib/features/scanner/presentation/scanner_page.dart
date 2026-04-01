import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/scanner_repository.dart';
import 'cubit/scanner_cubit.dart';
import 'cubit/scanner_intent.dart';
import 'cubit/scanner_state.dart';
import 'widgets/image_preview.dart';
import 'widgets/result_panel.dart';
import 'widgets/tutorial_card.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScannerCubit(MlKitScannerRepository()),
      child: const _ScannerView(),
    );
  }
}

class _ScannerView extends StatelessWidget {
  const _ScannerView();

  @override
  Widget build(BuildContext context) {
    final send = context.read<ScannerCubit>().processIntent;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pehchaan"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueGrey[900],
        elevation: 0.5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<ScannerCubit, ScannerState>(
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TutorialCard(),
                if (state.imagePath != null)
                  ImagePreview(path: state.imagePath!),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.camera_alt_outlined,
                        label: "Camera",
                        onPressed: () =>
                            send(const PickImageIntent(ImageOrigin.camera)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.photo_outlined,
                        label: "Gallery",
                        onPressed: () =>
                            send(const PickImageIntent(ImageOrigin.gallery)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: _ActionButton(
                    icon: Icons.refresh,
                    label: "Reset",
                    color: Colors.red,
                    onPressed: () => send(const ResetIntent()),
                  ),
                ),
                const SizedBox(height: 24),
                Divider(color: Colors.blueGrey[100], thickness: 1),
                const SizedBox(height: 16),
                ResultPanel(
                  title: "Extracted Text",
                  text: state.scannedText.isEmpty
                      ? "No text found"
                      : state.scannedText,
                  background: Colors.blueGrey[50],
                  textStyle: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 22),
                ResultPanel(
                  title: "Detected ID",
                  text: _idText(state),
                  background: Colors.green[50],
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _idText(ScannerState state) => switch (state.status) {
    ScanStatus.idle => "",
    ScanStatus.scanning => "Scanning...",
    ScanStatus.done => state.detectedId?.toString() ?? "No ID detected!",
    ScanStatus.failure => "Scan failed. Try another image.",
  };
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final MaterialColor? color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: color?[700] ?? Colors.blueGrey[800],
        side: BorderSide(color: color?[100] ?? Colors.blueGrey[200]!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(
          vertical: color == null ? 14 : 12,
          horizontal: color == null ? 0 : 24,
        ),
        textStyle: const TextStyle(fontSize: 15),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
      label: Text(label),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/appTheme.dart';
import '../../../widgets/custom_icon_widget.dart';


class BarcodeScannerWidget extends StatefulWidget {
  final Function(String) onBarcodeDetected;
  final VoidCallback onManualEntry;

  const BarcodeScannerWidget({
    Key? key,
    required this.onBarcodeDetected,
    required this.onManualEntry,
  }) : super(key: key);

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  MobileScannerController? _scannerController;
  bool _isInitialized = false;
  bool _hasPermission = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeScanner();
  }

  Future<void> _initializeScanner() async {
    try {
      final hasPermission = await _requestCameraPermission();
      if (!hasPermission) {
        setState(() {
          _errorMessage = 'Camera permission is required to scan barcodes';
        });
        return;
      }

      _scannerController = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
        torchEnabled: false,
      );

      await _scannerController!.start();

      setState(() {
        _isInitialized = true;
        _hasPermission = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize camera. Please try again.';
      });
    }
  }

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;

    final status = await Permission.camera.request();
    return status.isGranted;
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      final String barcode = barcodes.first.rawValue!;
      widget.onBarcodeDetected(barcode);
    }
  }

  @override
  void dispose() {
    _scannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          if (_isInitialized && _hasPermission && _scannerController != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: MobileScanner(
                controller: _scannerController!,
                onDetect: _onDetect,
              ),
            )
          else if (_errorMessage != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'camera_alt',
                    color: Colors.white,
                    size: 48,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _errorMessage!,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  TextButton(
                    onPressed: _initializeScanner,
                    child: Text(
                      'Retry',
                      style: TextStyle(color: AppTheme.accentLight),
                    ),
                  ),
                ],
              ),
            )
          else
            Center(
              child: CircularProgressIndicator(
                color: AppTheme.accentLight,
              ),
            ),

          if (_isInitialized && _hasPermission)
            Center(
              child: Container(
                width: 60.w,
                height: 30.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.accentLight,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    // Corner indicators
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: AppTheme.accentLight, width: 3),
                            left: BorderSide(
                                color: AppTheme.accentLight, width: 3),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: AppTheme.accentLight, width: 3),
                            right: BorderSide(
                                color: AppTheme.accentLight, width: 3),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppTheme.accentLight, width: 3),
                            left: BorderSide(
                                color: AppTheme.accentLight, width: 3),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppTheme.accentLight, width: 3),
                            right: BorderSide(
                                color: AppTheme.accentLight, width: 3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Positioned(
            bottom: 4.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Position barcode within the frame',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                ElevatedButton(
                  onPressed: widget.onManualEntry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                    foregroundColor: AppTheme.lightTheme.colorScheme.primary,
                    padding:
                    EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                  ),
                  child: Text('Enter Manually'),
                ),
              ],
            ),
          ),

          Positioned(
            top: 2.h,
            right: 4.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: CustomIconWidget(
                  iconName: 'close',
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


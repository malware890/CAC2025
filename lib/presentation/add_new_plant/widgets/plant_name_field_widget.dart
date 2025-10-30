import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/appTheme.dart';
import '../../../widgets/custom_icon_widget.dart';


class PlantNameFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? error;
  final bool isLoading;
  final Function(String) onBarcodeDetected;
  final VoidCallback onFieldChanged;

  const PlantNameFieldWidget({
    Key? key,
    required this.controller,
    this.error,
    this.isLoading = false,
    required this.onBarcodeDetected,
    required this.onFieldChanged,
  }) : super(key: key);

  @override
  State<PlantNameFieldWidget> createState() => _PlantNameFieldWidgetState();
}

class _PlantNameFieldWidgetState extends State<PlantNameFieldWidget> {
  bool _isScannerOpen = false;
  MobileScannerController? _scannerController;

  Future<void> _openBarcodeScanner() async {
    final hasPermission = await _requestCameraPermission();
    if (!hasPermission) {
      _showPermissionDialog();
      return;
    }

    setState(() {
      _isScannerOpen = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 90.h,
        child: _buildBarcodeScanner(),
      ),
    ).then((_) {
      setState(() {
        _isScannerOpen = false;
      });
      _scannerController?.dispose();
      _scannerController = null;
    });
  }

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Camera Permission Required'),
        content: Text(
            'Please grant camera permission to scan barcodes for plant identification.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text('Settings'),
          ),
        ],
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      final String barcode = barcodes.first.rawValue!;
      Navigator.pop(context);
      widget.onBarcodeDetected(barcode);
    }
  }

  Widget _buildBarcodeScanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: MobileScanner(
              controller: _scannerController ??= MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
                facing: CameraFacing.back,
                torchEnabled: false,
              ),
              onDetect: _onDetect,
            ),
          ),

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
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border(
                          top:
                          BorderSide(color: AppTheme.accentLight, width: 3),
                          left:
                          BorderSide(color: AppTheme.accentLight, width: 3),
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
                          top:
                          BorderSide(color: AppTheme.accentLight, width: 3),
                          right:
                          BorderSide(color: AppTheme.accentLight, width: 3),
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
                          bottom:
                          BorderSide(color: AppTheme.accentLight, width: 3),
                          left:
                          BorderSide(color: AppTheme.accentLight, width: 3),
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
                          bottom:
                          BorderSide(color: AppTheme.accentLight, width: 3),
                          right:
                          BorderSide(color: AppTheme.accentLight, width: 3),
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
            child: Text(
              'Position barcode within the frame to identify plant',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plant Name *',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: 'Enter plant name or scan barcode',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'local_florist',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            suffixIcon: widget.isLoading
                ? Padding(
              padding: EdgeInsets.all(3.w),
              child: SizedBox(
                width: 4.w,
                height: 4.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.lightTheme.colorScheme.primary,
                ),
              ),
            )
                : IconButton(
              onPressed: _isScannerOpen ? null : _openBarcodeScanner,
              icon: CustomIconWidget(
                iconName: 'qr_code_scanner',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              tooltip: 'Scan barcode to identify plant',
            ),
            errorText: widget.error,
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) => widget.onFieldChanged(),
        ),
        SizedBox(height: 1.h),
        Text(
          'Tap the barcode icon to scan and auto-fill the plant name',
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/appTheme.dart';
import '../../../widgets/custom_icon_widget.dart';


class ScanBarcodeButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const ScanBarcodeButtonWidget({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 15.h,
      child: Card(
        elevation: 4,
        shadowColor: AppTheme.lightTheme.colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.lightTheme.colorScheme.primaryContainer,
                  AppTheme.lightTheme.colorScheme.primaryContainer
                      .withValues(alpha: 0.8),
                ],
              ),
            ),
            child: isLoading
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 6.w,
                    height: 6.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Processing...',
                    style: AppTheme.lightTheme.textTheme.bodyMedium
                        ?.copyWith(
                      color: AppTheme
                          .lightTheme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            )
                : Row(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'qr_code_scanner',
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scan Barcode',
                        style: AppTheme.lightTheme.textTheme.titleMedium
                            ?.copyWith(
                          color: AppTheme
                              .lightTheme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        'Automatically identify your plant',
                        style: AppTheme.lightTheme.textTheme.bodySmall
                            ?.copyWith(
                          color: AppTheme
                              .lightTheme.colorScheme.onPrimaryContainer
                              .withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomIconWidget(
                  iconName: 'arrow_forward_ios',
                  color:
                  AppTheme.lightTheme.colorScheme.onPrimaryContainer,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

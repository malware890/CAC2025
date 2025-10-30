import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/appTheme.dart';
import '../../../widgets/custom_icon_widget.dart';


class SoilTypeSelectionWidget extends StatelessWidget {
  final String? selectedSoilType;
  final String? error;
  final Function(String?) onSoilTypeChanged;

  const SoilTypeSelectionWidget({
    Key? key,
    this.selectedSoilType,
    this.error,
    required this.onSoilTypeChanged,
  }) : super(key: key);

  final List<String> _soilTypes = const [
    'Clay Soil',
    'Sandy Soil',
    'Loamy Soil',
    'Silty Soil',
    'Peaty Soil',
    'Chalky Soil',
    'Potting Mix',
    'Compost Mix',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Soil Type *',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),

        DropdownButtonFormField<String>(
          value: selectedSoilType,
          decoration: InputDecoration(
            hintText: 'Select soil type',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'grass',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            errorText: error,
          ),
          items: _soilTypes.map((String soilType) {
            return DropdownMenuItem<String>(
              value: soilType,
              child: Text(soilType),
            );
          }).toList(),
          onChanged: onSoilTypeChanged,
          isExpanded: true,
        ),
        SizedBox(height: 2.h),

        Text(
          'Quick Select:',
          style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _soilTypes.take(4).map((String soilType) {
            final bool isSelected = selectedSoilType == soilType;
            return FilterChip(
              label: Text(soilType),
              selected: isSelected,
              onSelected: (bool selected) {
                onSoilTypeChanged(selected ? soilType : null);
              },
              selectedColor: AppTheme.lightTheme.colorScheme.primaryContainer,
              checkmarkColor: AppTheme.lightTheme.colorScheme.primary,
              labelStyle: TextStyle(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.onPrimaryContainer
                    : AppTheme.lightTheme.colorScheme.onSurface,
                fontSize: 12.sp,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

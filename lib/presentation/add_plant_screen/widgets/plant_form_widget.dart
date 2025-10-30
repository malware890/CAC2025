import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/appTheme.dart';
import '../../../widgets/custom_icon_widget.dart';


class PlantFormWidget extends StatefulWidget {
  final TextEditingController plantNameController;
  final String? selectedState;
  final String? selectedCity;
  final String? selectedSoilType;
  final Function(String?) onStateChanged;
  final Function(String?) onCityChanged;
  final Function(String?) onSoilTypeChanged;
  final String? plantNameError;
  final String? locationError;
  final String? soilTypeError;

  const PlantFormWidget({
    Key? key,
    required this.plantNameController,
    this.selectedState,
    this.selectedCity,
    this.selectedSoilType,
    required this.onStateChanged,
    required this.onCityChanged,
    required this.onSoilTypeChanged,
    this.plantNameError,
    this.locationError,
    this.soilTypeError,
  }) : super(key: key);

  @override
  State<PlantFormWidget> createState() => _PlantFormWidgetState();
}

class _PlantFormWidgetState extends State<PlantFormWidget> {
  final List<String> _states = [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming'
  ];

  final Map<String, List<String>> _citiesByState = {
    'California': [
      'Los Angeles',
      'San Francisco',
      'San Diego',
      'Sacramento',
      'Oakland'
    ],
    'Texas': ['Houston', 'Dallas', 'Austin', 'San Antonio', 'Fort Worth'],
    'Florida': ['Miami', 'Orlando', 'Tampa', 'Jacksonville', 'Tallahassee'],
    'New York': ['New York City', 'Buffalo', 'Rochester', 'Syracuse', 'Albany'],
    'Illinois': ['Chicago', 'Aurora', 'Rockford', 'Joliet', 'Naperville'],
  };

  final List<String> _soilTypes = [
    'Clay Soil',
    'Sandy Soil',
    'Loamy Soil',
    'Silty Soil',
    'Peaty Soil',
    'Chalky Soil',
    'Potting Mix',
    'Compost Mix',
  ];

  List<String> _getAvailableCities() {
    if (widget.selectedState == null) return [];
    return _citiesByState[widget.selectedState] ??
        ['City Center', 'Downtown', 'Suburbs', 'Outskirts'];
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
          controller: widget.plantNameController,
          decoration: InputDecoration(
            hintText: 'Enter plant name',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'local_florist',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            errorText: widget.plantNameError,
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            setState(() {});
          },
        ),
        SizedBox(height: 3.h),

        Text(
          'Location *',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),

        DropdownButtonFormField<String>(
          value: widget.selectedState,
          decoration: InputDecoration(
            hintText: 'Select state',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            errorText: widget.locationError,
          ),
          items: _states.map((String state) {
            return DropdownMenuItem<String>(
              value: state,
              child: Text(state),
            );
          }).toList(),
          onChanged: (String? newValue) {
            widget.onStateChanged(newValue);
            // Reset city when state changes
            widget.onCityChanged(null);
          },
          isExpanded: true,
        ),
        SizedBox(height: 2.h),

        DropdownButtonFormField<String>(
          value: widget.selectedCity,
          decoration: InputDecoration(
            hintText: 'Select city',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'location_city',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
          ),
          items: _getAvailableCities().map((String city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: widget.selectedState != null ? widget.onCityChanged : null,
          isExpanded: true,
        ),
        SizedBox(height: 3.h),

        Text(
          'Soil Type *',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),

        DropdownButtonFormField<String>(
          value: widget.selectedSoilType,
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
            errorText: widget.soilTypeError,
          ),
          items: _soilTypes.map((String soilType) {
            return DropdownMenuItem<String>(
              value: soilType,
              child: Text(soilType),
            );
          }).toList(),
          onChanged: widget.onSoilTypeChanged,
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
            final bool isSelected = widget.selectedSoilType == soilType;
            return FilterChip(
              label: Text(soilType),
              selected: isSelected,
              onSelected: (bool selected) {
                widget.onSoilTypeChanged(selected ? soilType : null);
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

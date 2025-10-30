import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/appTheme.dart';
import '../../../widgets/custom_icon_widget.dart';


class LocationSelectionWidget extends StatelessWidget {
  final String? selectedState;
  final String? selectedCity;
  final String? error;
  final Function(String?) onStateChanged;
  final Function(String?) onCityChanged;

  const LocationSelectionWidget({
    Key? key,
    this.selectedState,
    this.selectedCity,
    this.error,
    required this.onStateChanged,
    required this.onCityChanged,
  }) : super(key: key);

  final List<String> _states = const [
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

  final Map<String, List<String>> _citiesByState = const {
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

  List<String> _getAvailableCities() {
    if (selectedState == null) return [];
    return _citiesByState[selectedState] ??
        ['City Center', 'Downtown', 'Suburbs', 'Outskirts'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location *',
          style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),

        DropdownButtonFormField<String>(
          value: selectedState,
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
            errorText: error,
          ),
          items: _states.map((String state) {
            return DropdownMenuItem<String>(
              value: state,
              child: Text(state),
            );
          }).toList(),
          onChanged: (String? newValue) {
            onStateChanged(newValue);
          },
          isExpanded: true,
        ),
        SizedBox(height: 2.h),

        DropdownButtonFormField<String>(
          value: selectedCity,
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
          onChanged: selectedState != null ? onCityChanged : null,
          isExpanded: true,
        ),
      ],
    );
  }
}

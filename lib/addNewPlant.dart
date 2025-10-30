import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/location_selection_widget.dart';
import './widgets/plant_name_field_widget.dart';
import './widgets/soil_type_selection_widget.dart';

class AddNewPlant extends StatefulWidget {
  const AddNewPlant({Key? key}) : super(key: key);

  @override
  State<AddNewPlant> createState() => _AddNewPlantState();
}

class _AddNewPlantState extends State<AddNewPlant> {
  final _formKey = GlobalKey<FormState>();
  final _plantNameController = TextEditingController();

  String? _selectedState;
  String? _selectedCity;
  String? _selectedSoilType;

  String? _plantNameError;
  String? _locationError;
  String? _soilTypeError;

  bool _isLoading = false;

  // Mock plant database for barcode lookup
  final Map<String, String> _barcodeDatabase = {
    '123456789012': 'Rose Bush',
    '987654321098': 'Tomato Plant',
    '456789123456': 'Basil',
    '789123456789': 'Sunflower',
    '321654987321': 'Lavender',
    '654987321654': 'Mint',
    '147258369147': 'Oregano',
    '258369147258': 'Thyme',
    '369147258369': 'Rosemary',
    '741852963741': 'Sage',
  };

  @override
  void dispose() {
    _plantNameController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _plantNameError = null;
      _locationError = null;
      _soilTypeError = null;
    });

    bool hasErrors = false;

    if (_plantNameController.text.trim().isEmpty) {
      setState(() {
        _plantNameError = 'Plant name is required';
      });
      hasErrors = true;
    }

    if (_selectedState == null || _selectedCity == null) {
      setState(() {
        _locationError = 'Please select both state and city';
      });
      hasErrors = true;
    }

    if (_selectedSoilType == null) {
      setState(() {
        _soilTypeError = 'Soil type is required';
      });
      hasErrors = true;
    }

    if (!hasErrors) {
      _savePlant();
    }
  }

  Future<void> _savePlant() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Mock plant data
    final plantData = {
      'name': _plantNameController.text.trim(),
      'state': _selectedState,
      'city': _selectedCity,
      'soilType': _selectedSoilType,
      'dateAdded': DateTime.now().toIso8601String(),
    };

    setState(() {
      _isLoading = false;
    });

    // Show success message
    Fluttertoast.showToast(
      msg: 'Plant "${plantData['name']}" added successfully!',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      textColor: AppTheme.lightTheme.colorScheme.onPrimary,
    );

    // Navigate back
    Navigator.pop(context, plantData);
  }

  void _handleBarcodeDetected(String barcode) {
    setState(() {
      _isLoading = true;
    });

    // Simulate barcode lookup
    Future.delayed(Duration(seconds: 1), () {
      final plantName = _barcodeDatabase[barcode];

      if (plantName != null) {
        setState(() {
          _plantNameController.text = plantName;
          _isLoading = false;
          _plantNameError = null;
        });

        // Haptic feedback
        HapticFeedback.lightImpact();

        Fluttertoast.showToast(
          msg: 'Plant identified: $plantName',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppTheme.lightTheme.colorScheme.primary,
          textColor: AppTheme.lightTheme.colorScheme.onPrimary,
        );
      } else {
        setState(() {
          _isLoading = false;
        });

        Fluttertoast.showToast(
          msg: 'Plant not found. Please enter manually.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppTheme.getWarningColor(true),
          textColor: Colors.white,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Add New Plant'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'close',
            color: AppTheme.lightTheme.colorScheme.onPrimary,
            size: 24,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _validateForm,
            child: _isLoading
                ? SizedBox(
                    width: 4.w,
                    height: 4.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                    ),
                  )
                : Text(
                    'Save',
                    style: TextStyle(
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header text
                Text(
                  'Register your new plant',
                  style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'Fill in the plant details to add it to your collection',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 4.h),

                // Plant Name Field with integrated barcode scanner
                PlantNameFieldWidget(
                  controller: _plantNameController,
                  error: _plantNameError,
                  isLoading: _isLoading,
                  onBarcodeDetected: _handleBarcodeDetected,
                  onFieldChanged: () {
                    setState(() {
                      _plantNameError = null;
                    });
                  },
                ),
                SizedBox(height: 4.h),

                // Location Selection
                LocationSelectionWidget(
                  selectedState: _selectedState,
                  selectedCity: _selectedCity,
                  error: _locationError,
                  onStateChanged: (value) {
                    setState(() {
                      _selectedState = value;
                      _selectedCity = null; // Reset city when state changes
                      _locationError = null;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                      _locationError = null;
                    });
                  },
                ),
                SizedBox(height: 4.h),

                // Soil Type Selection
                SoilTypeSelectionWidget(
                  selectedSoilType: _selectedSoilType,
                  error: _soilTypeError,
                  onSoilTypeChanged: (value) {
                    setState(() {
                      _selectedSoilType = value;
                      _soilTypeError = null;
                    });
                  },
                ),
                SizedBox(height: 6.h),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 6.h,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _validateForm,
                    child: _isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 4.w,
                                height: 4.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color:
                                      AppTheme.lightTheme.colorScheme.onPrimary,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Text('Saving...'),
                            ],
                          )
                        : Text(
                            'Save Plant',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

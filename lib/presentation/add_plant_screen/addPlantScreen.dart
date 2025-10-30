import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({Key? key}) : super(key: key);
  @override _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  File? _image;
  String? _selectedPlant;
  String? _selectedSoil;

  final picker = ImagePicker();

  // Plant database with care info
  final Map<String, Map<String, String>> plantsDB = {
    'Rose': {'sun': 'Full sun', 'water': '3', 'soil': 'Well-drained', 'icon': 'rose'},
    'Tulip': {'sun': 'Full sun', 'water': '7', 'soil': 'Sandy', 'icon': 'tulip'},
    'Basil': {'sun': 'Full sun', 'water': '2', 'soil': 'Rich', 'icon': 'basil'},
    'Cactus': {'sun': 'Bright indirect', 'water': '21', 'soil': 'Cactus mix', 'icon': 'cactus'},
    'Lavender': {'sun': 'Full sun', 'water': '7', 'soil': 'Sandy', 'icon': 'lavender'},
    'Tomato': {'sun': 'Full sun', 'water': '2', 'soil': 'Rich', 'icon': 'tomato'},
    'Sunflower': {'sun': 'Full sun', 'water': '5', 'soil': 'Well-drained', 'icon': 'sunflower'},
    'Mint': {'sun': 'Partial shade', 'water': '3', 'soil': 'Moist', 'icon': 'mint'},
  };

  final List<String> soilTypes = ['Sandy', 'Clay', 'Loam', 'Silt', 'Cactus Mix', 'Rich Compost'];

  String? _weatherTip;
  String? _soilTip;

  @override
  void initState() {
    super.initState();
    _cityController.addListener(_updateTips);
    _stateController.addListener(_updateTips);
  }

  void _updateTips() {
    final city = _cityController.text.toLowerCase();
    final state = _stateController.text.toLowerCase();

    setState(() {
      if (city.contains('phoenix') || state.contains('az')) {
        _weatherTip = 'Hot & dry – water deeply but infrequently';
      } else if (city.contains('seattle') || state.contains('wa')) {
        _weatherTip = 'Cool & rainy – ensure good drainage';
      } else {
        _weatherTip = null;
      }

      if (_selectedSoil == 'Clay') {
        _soilTip = 'Add sand/perlite to improve drainage';
      } else if (_selectedSoil == 'Sandy') {
        _soilTip = 'Mix in compost to retain moisture';
      } else {
        _soilTip = null;
      }
    });
  }

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  void _savePlant() {
    if (!_formKey.currentState!.validate() || _selectedPlant == null || _selectedSoil == null) return;

    final data = plantsDB[_selectedPlant]!;
    final plant = {
      'name': _nameController.text.trim(),
      'nickname': '',
      'image': _image?.path ?? 'assets/plant_placeholder.png',
      'watering_frequency': int.parse(data['water']!),
      'last_watered': DateTime.now(),
      'sunlight': data['sun']!,
      'soil': _selectedSoil!,
      'pruning': data['icon'] == 'basil' ? 'Harvest often' : null,
      'notes': 'Location: ${_cityController.text}, ${_stateController.text}',
    };

    Navigator.pop(context, plant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _savePlant,
            child: Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(5.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Photo Picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 130, height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24, width: 3),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                      ),
                      child: _image != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 40, color: Colors.white70),
                          Text('Add Photo', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),

                  // Plant Name
                  _glassField(
                    controller: _nameController,
                    label: 'Plant Name (e.g. Rosie)',
                    icon: Icons.local_florist,
                    validator: (v) => v!.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 3.h),

                  // Plant Type
                  _glassDropdown(
                    value: _selectedPlant,
                    hint: 'Select Plant Type',
                    items: plantsDB.keys.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                    onChanged: (v) => setState(() => _selectedPlant = v),
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  SizedBox(height: 3.h),

                  // Location
                  Row(
                    children: [
                      Expanded(
                        child: _glassField(
                          controller: _cityController,
                          label: 'City',
                          icon: Icons.location_city,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: _glassField(
                          controller: _stateController,
                          label: 'State',
                          icon: Icons.map,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // Soil Type
                  _glassDropdown(
                    value: _selectedSoil,
                    hint: 'Select Soil Type',
                    items: soilTypes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (v) {
                      setState(() => _selectedSoil = v);
                      _updateTips();
                    },
                    validator: (v) => v == null ? 'Required' : null,
                  ),
                  SizedBox(height: 3.h),

                  // Smart Tips
                  if (_weatherTip != null || _soilTip != null)
                    Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        children: [
                          if (_weatherTip != null)
                            Row(children: [Icon(Icons.wb_sunny, color: Colors.amber), SizedBox(width: 8), Expanded(child: Text(_weatherTip!, style: TextStyle(color: Colors.amber[100])))]),
                          if (_soilTip != null)
                            Row(children: [Icon(Icons.grass, color: Colors.brown[300]), SizedBox(width: 8), Expanded(child: Text(_soilTip!, style: TextStyle(color: Colors.brown[100])))]),
                        ],
                      ),
                    ),
                  SizedBox(height: 5.h),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 7.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF2E7D32),
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: _savePlant,
                      child: Text('Add to My Garden', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassField({required TextEditingController controller, required String label, required IconData icon, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white24)),
      ),
      validator: validator,
    );
  }

  Widget _glassDropdown({String? value, required String hint, required List<DropdownMenuItem<String>> items, required Function(String?) onChanged, String? Function(String?)? validator}) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint, style: TextStyle(color: Colors.white70)),
      dropdownColor: Color(0xFF1B5E20),
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white24)),
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
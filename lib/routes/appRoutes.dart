import 'package:flutter/material.dart';
import '../../../presentation/add_plant_screen/addPlantScreen.dart';
import '../../../presentation/add_new_plant/addNewPlant.dart';

class AppRoutes {
  static const String initial = '/';
  static const String addPlantScreen = '/add-plant-screen';
  static const String addNewPlant = '/add-new-plant';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => AddPlantScreen(),
    addPlantScreen: (context) => AddPlantScreen(),
    addNewPlant: (context) => const AddNewPlant(),
  };
}

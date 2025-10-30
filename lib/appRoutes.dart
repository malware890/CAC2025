import 'package:flutter/material.dart';
import '../presentation/add_plant_screen/add_plant_screen.dart';
import '../presentation/add_new_plant/add_new_plant.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String addPlantScreen = '/add-plant-screen';
  static const String addNewPlant = '/add-new-plant';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => AddPlantScreen(),
    addPlantScreen: (context) => AddPlantScreen(),
    addNewPlant: (context) => const AddNewPlant(),
    // TODO: Add your other routes here
  };
}

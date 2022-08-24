import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Meal> _availableMeals;
  late List<Meal> _favoriteMeals;
  late Settings _settings;

  @override
  void initState() {
    super.initState();
    _availableMeals = dummyMeals;
    _favoriteMeals = [];
    _settings = Settings(
        isGlutenFree: false,
        isLactoseFree: false,
        isVegan: false,
        isVegetarian: false);
  }

  void _filterMeals(Settings settings) {
    setState(() {
      _availableMeals.clear();
      _availableMeals.addAll(dummyMeals.where((meal) {
        final filterFluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterFluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList());
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() => _favoriteMeals.contains(meal)
        ? _favoriteMeals.remove(meal)
        : _favoriteMeals.add(meal));
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.amber),
          fontFamily: 'Raleway',
          canvasColor: const Color.fromRGBO(255, 254, 229, 0.8),
          textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                  fontSize: 20, fontFamily: 'RobotoCondensed'))),
      routes: {
        AppRoutes.HOME: (context) => TabsScreen(_favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (context) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (context) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.SETTINGS: (context) =>
            SettingsScreen(_settings, _filterMeals),
      },
    );
  }
}

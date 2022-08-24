class Settings {
  bool isGlutenFree;
  bool isLactoseFree;
  bool isVegan;
  bool isVegetarian;

  Settings(
      {required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian});

  @override
  String toString() =>
      'Settings - Gluten Free: $isGlutenFree, Lactose Free: $isLactoseFree, Vegan: $isVegan, Vegetarian: $isVegetarian';
}

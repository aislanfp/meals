import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Widget> _screens;
  late List<Meal> _favoriteMeals;
  late List<Map<String, Object>> _screensMap;
  int _selectedScreenIndex = 0;
  bool _tabAppBar = true;

  void _selectScreen(int index) {
    setState(() {
      _tabAppBar = false;
      _selectedScreenIndex = index;
    });
  }

  void _tabBar(bool value) {
    setState(() {
      _tabAppBar = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _favoriteMeals = widget.favoriteMeals;
    _screens = <Widget>[
      const CategoriesScreen(),
      FavoriteScreen(_favoriteMeals),
    ];
    _screensMap = <Map<String, Object>>[
      {'title': 'Lista de Categorias', 'screen': _screens[0]},
      {'title': 'Favoritos', 'screen': _screens[1]},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vamos Cozinhar?'),
          bottom: TabBar(onTap: (_) => _tabBar(true), tabs: const [
            Tab(
              icon: Icon(Icons.category),
              text: 'Categorias',
            ),
            Tab(
              icon: Icon(Icons.star),
              text: 'Favoritos',
            ),
          ]),
        ),
        body: (_tabAppBar)
            ? TabBarView(children: _screens)
            : _screensMap[_selectedScreenIndex].cast()['screen'],
        drawer: const MainDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectScreen,
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _selectedScreenIndex,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categorias'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

const _screens = <Widget>[
  CategoriesScreen(),
  FavoriteScreen(),
];

class _TabsScreenState extends State<TabsScreen> {
  final _screensMap = <Map<String, Object>>[
    {'title': 'Lista de Categorias', 'screen': _screens[0]},
    {'title': 'Favoritos', 'screen': _screens[1]},
  ];

  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _tabAppBar = false;
      _selectedScreenIndex = index;
    });
  }

  bool _tabAppBar = true;

  void _tabBar(bool value) {
    setState(() {
      _tabAppBar = value;
    });
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
            ? const TabBarView(children: _screens)
            : _screensMap[_selectedScreenIndex].cast()['screen'],
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

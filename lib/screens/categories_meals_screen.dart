import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final Category category;

  const CategoriesMealsScreen(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
      ),
      body: Text('Receitas por Categoria ${category.title}'),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/category_meals.dart';
import 'screens/detail.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const CategoriesHome(),
        '/categoryMeals': (ctx) => const CategoryMealsPage(),
        '/detail': (ctx) => const MealDetailPage(),
      },
    );
  }
}

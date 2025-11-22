import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/meal_model.dart';
import '../widgets/meal_card.dart';

class CategoryMealsPage extends StatefulWidget {
  const CategoryMealsPage({super.key});

  @override
  State<CategoryMealsPage> createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  final ApiService api = ApiService();
  List<Meal> _meals = [];
  bool _loading = true;
  final TextEditingController _controller = TextEditingController();
  String _category = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null && arg is String) {
      _category = arg;
      _loadMeals();
    }
  }

  Future<void> _loadMeals() async {
    setState(() => _loading = true);
    try {
      final list = await api.loadMealsByCategory(_category);
      setState(() {
        _meals = list;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _search(String q) async {
    if (q.trim().isEmpty) {
      await _loadMeals();
      return;
    }
    setState(() => _loading = true);
    final results = await api.searchMealsByName(q);
    setState(() {
      _meals = results;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_category),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search meals...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: _search,
            ),
          ),
          Expanded(
            child: _meals.isEmpty
                ? const Center(child: Text('There are no results for this category.'))
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
                itemCount: _meals.length,
                itemBuilder: (context, i) => MealCard(meal: _meals[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

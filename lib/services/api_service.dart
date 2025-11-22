import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/meal_model.dart';

class ApiService {
  static const String base = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Map<String, dynamic>>> loadCategoriesRaw() async {
    final res = await http.get(Uri.parse('$base/categories.php'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['categories'] ?? [];
      return List<Map<String, dynamic>>.from(list);
    }
    throw Exception('Failed to load categories');
  }

  Future<List<Meal>> loadMealsByCategory(String category) async {
    final res = await http.get(Uri.parse('$base/filter.php?c=$category'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      return list.map<Meal>((e) => Meal.fromJson(e)).toList();
    }
    throw Exception('Failed to load meals for category $category');
  }

  Future<MealDetail> fetchMealDetail(String id) async {
    final res = await http.get(Uri.parse('$base/lookup.php?i=$id'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      if (list.isEmpty) throw Exception('Meal not found');
      return MealDetail.fromJson(list.first);
    }
    throw Exception('Failed to load meal detail for id $id');
  }

  Future<MealDetail> fetchRandomMeal() async {
    final res = await http.get(Uri.parse('$base/random.php'));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      return MealDetail.fromJson(list.first);
    }
    throw Exception('Failed to load random meal');
  }

  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse("$base/categories.php"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categories = data['categories'];
      return categories.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(Uri.parse("$base/filter.php?c=$category"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List meals = data['meals'];
      return meals.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load meals");
    }
  }

  Future<List<Meal>> searchMealsByName(String query) async {
    final response = await http.get(Uri.parse("$base/search.php?s=$query"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null) {
        final List meals = data['meals'];
        return meals.map((json) => Meal.fromJson(json)).toList();
      }
      return [];
    } else {
      throw Exception("Failed to search meals");
    }
  }
}


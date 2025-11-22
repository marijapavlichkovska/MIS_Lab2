class Meal {
  final String id;
  final String name;
  final String thumbnail;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory Meal.fromJson(Map<String, dynamic> data) {
    return Meal(
      id: data['idMeal'] ?? '',
      name: data['strMeal'] ?? '',
      thumbnail: data['strMealThumb'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'thumbnail': thumbnail,
  };
}

class MealDetail {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String youtube;
  final Map<String, String> ingredients; // ingredient -> measure

  MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.youtube,
    required this.ingredients,
  });

  factory MealDetail.fromJson(Map<String, dynamic> data) {
    final Map<String, String> ingr = {};
    for (int i = 1; i <= 20; i++) {
      final ing = data['strIngredient$i'];
      final meas = data['strMeasure$i'];
      if (ing != null && (ing as String).trim().isNotEmpty) {
        ingr[ing] = (meas ?? '').toString().trim();
      }
    }
    return MealDetail(
      id: data['idMeal'] ?? '',
      name: data['strMeal'] ?? '',
      category: data['strCategory'] ?? '',
      area: data['strArea'] ?? '',
      instructions: data['strInstructions'] ?? '',
      thumbnail: data['strMealThumb'] ?? '',
      youtube: data['strYoutube'] ?? '',
      ingredients: ingr,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'area': area,
    'instructions': instructions,
    'thumbnail': thumbnail,
    'youtube': youtube,
    'ingredients': ingredients,
  };
}

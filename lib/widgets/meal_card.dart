import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/meal_model.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: meal.id),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: meal.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (c, s) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (c, s, e) => const Icon(Icons.error),
                ),
              ),
              const Divider(),
              Text(meal.name, style: const TextStyle(fontSize: 16), maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}

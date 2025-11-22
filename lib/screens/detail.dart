import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/meal_model.dart';
import '../services/api_service.dart';

class MealDetailPage extends StatefulWidget {
  const MealDetailPage({super.key});

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  MealDetail? detail;
  bool loading = true;
  final ApiService _api = ApiService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null) {
      if (arg is MealDetail) {
        detail = arg;
        loading = false;
      } else if (arg is String) {
        _fetchDetail(arg);
      }
    }
  }

  Future<void> _fetchDetail(String id) async {
    setState(() => loading = true);
    try {
      final d = await _api.fetchMealDetail(id);
      setState(() {
        detail = d;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(detail?.name ?? 'Receipt'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : detail == null
          ? const Center(child: Text('There is no data for this receipt.'))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: detail!.thumbnail, height: 220, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(detail!.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Category: ${detail!.category}  •  Area: ${detail!.area}'),
            const SizedBox(height: 12),
            const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            ...detail!.ingredients.entries.map((e) => Text('- ${e.key}: ${e.value}')),
            const SizedBox(height: 12),
            const Text('Instructions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text(detail!.instructions),
            const SizedBox(height: 12),
            if (detail!.youtube.isNotEmpty) ...[
              const Text('YouTube', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(detail!.youtube, style: const TextStyle(color: Colors.blue)),
            ]
          ],
        ),
      ),
    );
  }
}

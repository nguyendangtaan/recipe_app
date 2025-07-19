import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../models/meal.dart';
import '../widgets/favorite_button.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? mealId;
  bool _didFetch = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didFetch) {
      mealId = ModalRoute.of(context)!.settings.arguments as String?;
      if (mealId != null) {
        Provider.of<MealProvider>(context, listen: false).fetchMealDetail(mealId!);
        _didFetch = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết'),
      ),
      body: Consumer<MealProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingDetail || provider.mealDetail == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final meal = provider.mealDetail!;
          final mealObj = Meal(
            id: meal['idMeal'],
            name: meal['strMeal'],
            thumbnail: meal['strMealThumb'],
          );
          List<Widget> ingredients = [];
          for (int i = 1; i <= 20; i++) {
            final ingredient = meal['strIngredient$i'];
            final measure = meal['strMeasure$i'];
            if (ingredient != null && ingredient.toString().isNotEmpty) {
              ingredients.add(
                Text('- $ingredient: $measure'),
              );
            }
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(meal['strMealThumb'] ?? '', width: double.infinity, height: 220, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              meal['strMeal'] ?? '',
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          FavoriteButton(meal: mealObj),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Nguyên liệu:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ...ingredients,
                      const SizedBox(height: 8),
                      const Text('Hướng dẫn:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(meal['strInstructions'] ?? ''),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 
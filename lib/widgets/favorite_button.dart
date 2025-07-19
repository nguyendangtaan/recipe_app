import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../models/meal.dart';

class FavoriteButton extends StatelessWidget {
  final Meal meal;
  final double? size;

  const FavoriteButton({
    super.key,
    required this.meal,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        final isFavorite = provider.isFavorite(meal.id);
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: size,
          ),
          onPressed: () {
            if (isFavorite) {
              provider.removeFavorite(meal.id);
            } else {
              provider.addFavorite(meal);
            }
          },
        );
      },
    );
  }
} 
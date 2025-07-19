import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal.dart';
import 'dart:convert';

class FavoriteProvider with ChangeNotifier {
  List<Meal> _favorites = [];

  List<Meal> get favorites => _favorites;

  FavoriteProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];
    _favorites = favs.map((e) => Meal.fromJson(json.decode(e))).toList();
    notifyListeners();
  }

  Future<void> addFavorite(Meal meal) async {
    if (_favorites.any((m) => m.id == meal.id)) return;
    _favorites.add(meal);
    await _save();
    notifyListeners();
  }

  Future<void> removeFavorite(String id) async {
    _favorites.removeWhere((m) => m.id == id);
    await _save();
    notifyListeners();
  }

  bool isFavorite(String id) => _favorites.any((m) => m.id == id);

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = _favorites.map((e) => json.encode({
      'idMeal': e.id,
      'strMeal': e.name,
      'strMealThumb': e.thumbnail,
    })).toList();
    await prefs.setStringList('favorites', favs);
  }
} 
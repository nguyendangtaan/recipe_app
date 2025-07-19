import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';

class MealProvider with ChangeNotifier {
  List<Meal> _meals = [];
  bool _isLoading = false;

  List<Meal> get meals => _meals;
  bool get isLoading => _isLoading;

  // Recent meals
  List<Meal> _recentMeals = [];
  bool _isLoadingRecent = false;
  List<Meal> get recentMeals => _recentMeals;
  bool get isLoadingRecent => _isLoadingRecent;

  // Ingredients
  List<String> _ingredients = [];
  bool _isLoadingIngredients = false;
  List<String> get ingredients => _ingredients;
  bool get isLoadingIngredients => _isLoadingIngredients;

  List<Meal> _searchResults = [];
  bool _isSearching = false;
  List<Meal> get searchResults => _searchResults;
  bool get isSearching => _isSearching;

  List<Meal> _suggestions = [];
  bool _isLoadingSuggestions = false;
  List<Meal> get suggestions => _suggestions;
  bool get isLoadingSuggestions => _isLoadingSuggestions;

  // Random meals for SearchScreen2
  List<Meal> _randomMeals = [];
  bool _isLoadingRandom = false;
  List<Meal> get randomMeals => _randomMeals;
  bool get isLoadingRandom => _isLoadingRandom;

  Future<void> fetchMealsByCategory(String category) async {
    _isLoading = true;
    notifyListeners();
    _meals = await ApiService.fetchMealsByCategory(category);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRecentMeals() async {
    _isLoadingRecent = true;
    notifyListeners();
    _recentMeals = await ApiService.fetchRecentMeals();
    _isLoadingRecent = false;
    notifyListeners();
  }

  Future<void> fetchIngredients() async {
    _isLoadingIngredients = true;
    notifyListeners();
    _ingredients = await ApiService.fetchIngredients();
    _isLoadingIngredients = false;
    notifyListeners();
  }

  Future<void> searchMeals(String query) async {
    _isSearching = true;
    notifyListeners();
    _searchResults = await ApiService.searchMeals(query);
    _isSearching = false;
    notifyListeners();
  }

  Future<void> suggestMealsByFirstLetter(String letter) async {
    _isLoadingSuggestions = true;
    notifyListeners();
    _suggestions = await ApiService.suggestMealsByFirstLetter(letter);
    _isLoadingSuggestions = false;
    notifyListeners();
  }

  Future<void> fetchRandomMeals() async {
    _isLoadingRandom = true;
    notifyListeners();
    _randomMeals = await ApiService.fetchRandomMeals();
    _isLoadingRandom = false;
    notifyListeners();
  }

  Future<void> fetchMealsByIngredient(String ingredient) async {
    _isLoading = true;
    notifyListeners();
    _meals = await ApiService.fetchMealsByIngredient(ingredient);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMealsByArea(String area) async {
    _isLoading = true;
    notifyListeners();
    _meals = await ApiService.fetchMealsByArea(area);
    _isLoading = false;
    notifyListeners();
  }
  Map<String, dynamic>? _mealDetail;
  bool _isLoadingDetail = false;
  Map<String, dynamic>? get mealDetail => _mealDetail;
  bool get isLoadingDetail => _isLoadingDetail;

  Future<void> fetchMealDetail(String id) async {
    _isLoadingDetail = true;
    notifyListeners();
    _mealDetail = await ApiService.fetchMealDetail(id);
    _isLoadingDetail = false;
    notifyListeners();
  }
} 
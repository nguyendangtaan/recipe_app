import 'package:flutter/material.dart';
import '../services/api_service.dart';

class FilterProvider with ChangeNotifier {
  List<String> _categories = [];
  List<String> _ingredients = [];
  List<String> _areas = [];
  
  bool _isLoadingCategories = false;
  bool _isLoadingIngredients = false;
  bool _isLoadingAreas = false;

  List<String> get categories => _categories;
  List<String> get ingredients => _ingredients;
  List<String> get areas => _areas;
  
  bool get isLoadingCategories => _isLoadingCategories;
  bool get isLoadingIngredients => _isLoadingIngredients;
  bool get isLoadingAreas => _isLoadingAreas;

  Future<void> fetchCategories() async {
    if (_categories.isNotEmpty) return; // Already loaded
    
    _isLoadingCategories = true;
    notifyListeners();
    
    try {
      final response = await ApiService.fetchCategoriesList();
      _categories = response;
    } catch (e) {
      // Fallback to sample data
      _categories = ['Beef', 'Chicken', 'Dessert', 'Lamb', 'Miscellaneous', 'Pasta', 'Pork', 'Seafood', 'Side', 'Starter', 'Vegan', 'Vegetarian'];
    }
    
    _isLoadingCategories = false;
    notifyListeners();
  }

  Future<void> fetchIngredients() async {
    if (_ingredients.isNotEmpty) return; // Already loaded
    
    _isLoadingIngredients = true;
    notifyListeners();
    
    try {
      _ingredients = await ApiService.fetchIngredients();
    } catch (e) {
      // Fallback to sample data
      _ingredients = ['Chicken', 'Pork', 'Beef', 'Fish', 'Rice', 'Tomato', 'Onion', 'Garlic', 'Cheese', 'Milk'];
    }
    
    _isLoadingIngredients = false;
    notifyListeners();
  }

  Future<void> fetchAreas() async {
    if (_areas.isNotEmpty) return; // Already loaded
    
    _isLoadingAreas = true;
    notifyListeners();
    
    try {
      final response = await ApiService.fetchAreasList();
      _areas = response;
    } catch (e) {
      // Fallback to sample data
      _areas = ['American', 'British', 'Chinese', 'French', 'Indian', 'Italian', 'Japanese', 'Mexican', 'Thai', 'Vietnamese'];
    }
    
    _isLoadingAreas = false;
    notifyListeners();
  }

  Future<void> loadAllFilterData() async {
    await Future.wait([
      fetchCategories(),
      fetchIngredients(),
      fetchAreas(),
    ]);
  }
} 
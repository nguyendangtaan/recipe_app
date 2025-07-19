import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['categories'] as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Meal>> fetchMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  static Future<List<Meal>> fetchRecentMeals() async {
    // Lấy 10 món random (gọi 10 lần random.php)
    List<Meal> meals = [];
    for (int i = 0; i < 10; i++) {
      final response = await http.get(Uri.parse('$baseUrl/random.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        meals.add(Meal.fromJson(data['meals'][0]));
      }
    }
    return meals;
  }

  static Future<List<String>> fetchIngredients() async {
    final response = await http.get(Uri.parse('$baseUrl/list.php?i=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['meals'] as List)
          .map<String>((json) => json['strIngredient'])
          .toList();
    } else {
      throw Exception('Failed to load ingredients');
    }
  }
  static Future<Map<String, dynamic>> fetchMealDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['meals'][0];
    } else {
      throw Exception('Failed to load meal detail');
    }
  }

  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to search meals');
    }
  }

  static Future<List<Meal>> suggestMealsByFirstLetter(String letter) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?f=$letter'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to get suggestions');
    }
  }

  static Future<List<Meal>> fetchRandomMeals() async {
    // Lấy 10 món random cho SearchScreen2
    List<Meal> meals = [];
    for (int i = 0; i < 10; i++) {
      final response = await http.get(Uri.parse('$baseUrl/random.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        meals.add(Meal.fromJson(data['meals'][0]));
      }
    }
    return meals;
  }

  static Future<List<Meal>> fetchMealsByIngredient(String ingredient) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?i=$ingredient'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load meals by ingredient');
    }
  }

  static Future<List<Meal>> fetchMealsByArea(String area) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?a=$area'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load meals by area');
    }
  }

  static Future<List<String>> fetchCategoriesList() async {
    final response = await http.get(Uri.parse('$baseUrl/list.php?c=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['meals'] as List)
          .map<String>((json) => json['strCategory'])
          .toList();
    } else {
      throw Exception('Failed to load categories list');
    }
  }

  static Future<List<String>> fetchAreasList() async {
    final response = await http.get(Uri.parse('$baseUrl/list.php?a=list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['meals'] as List)
          .map<String>((json) => json['strArea'])
          .toList();
    } else {
      throw Exception('Failed to load areas list');
    }
  }
} 
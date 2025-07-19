import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../providers/meal_provider.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/loading_widget.dart';
import '../widgets/custom_bottom_nav.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    final mealProvider = Provider.of<MealProvider>(context, listen: false);
    categoryProvider.fetchCategories().then((_) {
      if (categoryProvider.categories.isNotEmpty) {
        setState(() {
          selectedCategory = categoryProvider.categories.first.name;
        });
        mealProvider.fetchMealsByCategory(selectedCategory!);
      }
    });
    mealProvider.fetchRecentMeals();
    mealProvider.fetchIngredients();
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
    Provider.of<MealProvider>(context, listen: false)
        .fetchMealsByCategory(category);
  }

  // Bottom navigation is now handled by MainScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Tìm kiếm sản phẩm',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCategorySection(),
          const SizedBox(height: 16),
          _buildMealSection(),
          const SizedBox(height: 16),
          _buildRecentSection(),
          const SizedBox(height: 16),
          _buildIngredientSection(),
        ],
      ),
      // Bottom navigation and FAB are now handled by MainScreen
    );
  }

  Widget _buildCategorySection() {
    return Consumer<CategoryProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const LoadingWidget();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Danh mục', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Spacer(),
                TextButton(onPressed: () {}, child: Text('Xem tất cả')),
              ],
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.categories.length,
                itemBuilder: (context, index) {
                  final category = provider.categories[index];
                  return CategoryChip(
                    name: category.name,
                    isSelected: selectedCategory == category.name,
                    onTap: () => _onCategorySelected(category.name),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMealSection() {
    return Consumer<MealProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const LoadingWidget();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Món ăn nổi bật', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(
              height: 170,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.meals.length,
                itemBuilder: (context, index) {
                  final meal = provider.meals[index];
                  return MealCard(meal: meal);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecentSection() {
    return Consumer<MealProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingRecent) {
          return const LoadingWidget();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Công thức gần đây', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.recentMeals.length,
                itemBuilder: (context, index) {
                  final meal = provider.recentMeals[index];
                  return MealCard(meal: meal);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildIngredientSection() {
    return Consumer<MealProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingIngredients) {
          return const LoadingWidget();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nguyên liệu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Wrap(
              spacing: 8,
              children: provider.ingredients.take(12).map((ingredient) {
                return Chip(label: Text(ingredient));
              }).toList(),
            ),
          ],
        );
      },
    );
  }
} 
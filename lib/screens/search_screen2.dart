import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../models/meal.dart';
import '../widgets/filter_bottom_sheet.dart';

class SearchScreen2 extends StatefulWidget {
  const SearchScreen2({super.key});

  @override
  State<SearchScreen2> createState() => _SearchScreen2State();
}

class _SearchScreen2State extends State<SearchScreen2> {
  final TextEditingController _controller = TextEditingController();
  String _lastQuery = '';
  bool _isFiltered = false;

  @override
  void initState() {
    super.initState();
    // Load random meals initially
    Provider.of<MealProvider>(context, listen: false).fetchRandomMeals();
  }

  void _onSearch(String value) {
    if (value.trim().isEmpty || value == _lastQuery) return;
    _lastQuery = value;
    setState(() {
      _isFiltered = false;
    });
    Provider.of<MealProvider>(context, listen: false).searchMeals(value);
  }

  void _onChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        _isFiltered = false;
      });
      Provider.of<MealProvider>(context, listen: false).fetchRandomMeals();
    } else if (value.length == 1) {
      Provider.of<MealProvider>(context, listen: false).suggestMealsByFirstLetter(value[0]);
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        onApplyFilter: (selectedCategory, selectedIngredient, selectedArea) {
          setState(() {
            _isFiltered = true;
          });
          // Apply filters
          if (selectedCategory != null) {
            Provider.of<MealProvider>(context, listen: false)
                .fetchMealsByCategory(selectedCategory);
          } else if (selectedIngredient != null) {
            Provider.of<MealProvider>(context, listen: false)
                .fetchMealsByIngredient(selectedIngredient);
          } else if (selectedArea != null) {
            Provider.of<MealProvider>(context, listen: false)
                .fetchMealsByArea(selectedArea);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Tìm kiếm',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: _onChanged,
            onSubmitted: _onSearch,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Consumer<MealProvider>(
        builder: (context, provider, child) {
          if (_controller.text.isEmpty && !_isFiltered) {
            // Show random meals
            if (provider.isLoadingRandom) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.randomMeals.isEmpty) {
              return const Center(child: Text('Không có món ăn nào'));
            }
            return _buildMealGrid(provider.randomMeals);
          }

          if (_controller.text.isNotEmpty && _controller.text.length == 1) {
            // Show suggestions
            if (provider.isLoadingSuggestions) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.suggestions.isEmpty) {
              return const Center(child: Text('Không có gợi ý'));
            }
            return _buildMealGrid(provider.suggestions);
          }

          // Show search results or filtered results
          if (provider.isSearching || provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.searchResults.isEmpty && provider.meals.isEmpty) {
            return const Center(child: Text('Không tìm thấy món ăn nào'));
          }
          return _buildMealGrid(_isFiltered ? provider.meals : provider.searchResults);
        },
      ),
    );
  }

  Widget _buildMealGrid(List<Meal> meals) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return _buildMealCard(meal);
      },
    );
  }

  Widget _buildMealCard(Meal meal) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: meal.id);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      meal.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        // Handle favorite
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  meal.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
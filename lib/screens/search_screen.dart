import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../models/meal.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    Provider.of<MealProvider>(context, listen: false).suggestMealsByFirstLetter('a');
  }

  void _onSearch(String value) {
    if (value.trim().isEmpty || value == _lastQuery) return;
    _lastQuery = value;
    Provider.of<MealProvider>(context, listen: false).searchMeals(value);
  }

  void _onChanged(String value) {
    if (value.isEmpty) {
      Provider.of<MealProvider>(context, listen: false).suggestMealsByFirstLetter('a');
    } else if (value.length == 1) {
      Provider.of<MealProvider>(context, listen: false).suggestMealsByFirstLetter(value[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm món ăn',
            border: InputBorder.none,
          ),
          onChanged: _onChanged,
          onSubmitted: _onSearch,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<MealProvider>(
        builder: (context, provider, child) {
          if (_controller.text.isEmpty || _controller.text.length == 1) {
            if (provider.isLoadingSuggestions) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.suggestions.isEmpty) {
              return const Center(child: Text('Không có gợi ý'));
            }
            return ListView(
              children: provider.suggestions.map((meal) => ListTile(
                title: Text(meal.name),
                onTap: () {
                  _controller.text = meal.name;
                  _onSearch(meal.name);
                },
              )).toList(),
            );
          }
          if (provider.isSearching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.searchResults.isEmpty) {
            return const Center(child: Text('Không tìm thấy món ăn nào'));
          }
          return ListView.builder(
            itemCount: provider.searchResults.length,
            itemBuilder: (context, index) {
              final meal = provider.searchResults[index];
              return ListTile(
                leading: Image.network(meal.thumbnail, width: 56, height: 56, fit: BoxFit.cover),
                title: Text(meal.name),
                onTap: () {
                  Navigator.pushNamed(context, '/detail', arguments: meal.id);
                },
              );
            },
          );
        },
      ),
      // Bottom navigation and FAB are now handled by MainScreen
    );
  }
} 
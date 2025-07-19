import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/filter_provider.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(String? category, String? ingredient, String? area) onApplyFilter;

  const FilterBottomSheet({
    super.key,
    required this.onApplyFilter,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedCategory;
  String? selectedIngredient;
  String? selectedArea;

  @override
  void initState() {
    super.initState();
    // Load filter data when bottom sheet opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FilterProvider>(context, listen: false).loadAllFilterData();
    });
  }

  void _resetFilters() {
    setState(() {
      selectedCategory = null;
      selectedIngredient = null;
      selectedArea = null;
    });
  }

  void _applyFilters() {
    widget.onApplyFilter(selectedCategory, selectedIngredient, selectedArea);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Text(
                    'Lọc',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  onPressed: _resetFilters,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Đặt lại',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Filter content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<FilterProvider>(
                    builder: (context, filterProvider, child) {
                      return Column(
                        children: [
                          // Categories
                          _buildFilterSection(
                            title: 'Danh mục',
                            items: filterProvider.categories,
                            selectedItem: selectedCategory,
                            isLoading: filterProvider.isLoadingCategories,
                            onItemSelected: (item) {
                              setState(() {
                                selectedCategory = selectedCategory == item ? null : item;
                                selectedIngredient = null;
                                selectedArea = null;
                              });
                            },
                          ),
                          const SizedBox(height: 30),
                          // Ingredients
                          _buildFilterSection(
                            title: 'Nguyên liệu',
                            items: filterProvider.ingredients,
                            selectedItem: selectedIngredient,
                            isLoading: filterProvider.isLoadingIngredients,
                            onItemSelected: (item) {
                              setState(() {
                                selectedIngredient = selectedIngredient == item ? null : item;
                                selectedCategory = null;
                                selectedArea = null;
                              });
                            },
                          ),
                          const SizedBox(height: 30),
                          // Areas
                          _buildFilterSection(
                            title: 'Khu vực',
                            items: filterProvider.areas,
                            selectedItem: selectedArea,
                            isLoading: filterProvider.isLoadingAreas,
                            onItemSelected: (item) {
                              setState(() {
                                selectedArea = selectedArea == item ? null : item;
                                selectedCategory = null;
                                selectedIngredient = null;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Confirm button
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Xác nhận',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> items,
    required String? selectedItem,
    required bool isLoading,
    required Function(String) onItemSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.folder, size: 20, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: items.map((item) {
              final isSelected = selectedItem == item;
              return GestureDetector(
                onTap: () => onItemSelected(item),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.amber : Colors.white,
                    border: Border.all(
                      color: isSelected ? Colors.amber : Colors.grey[300]!,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
} 
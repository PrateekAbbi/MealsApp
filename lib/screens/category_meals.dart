import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";

  final List<Meal> availableMeals;

  const CategoryMealsScreen({Key? key, required this.availableMeals})
      : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final String categoryId;
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs["title"];
      final caregoryId = routeArgs["id"];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(caregoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!)),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            title: displayedMeals![index].title,
            imageUrl: displayedMeals![index].imageUrl,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            affordability: displayedMeals![index].affordability,
            id: displayedMeals![index].id,
          );
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}

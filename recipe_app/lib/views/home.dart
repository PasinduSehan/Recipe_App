import 'package:flutter/material.dart';


import '../models/recipe.api.dart';
import '../models/recipe.dart';
import 'widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Food Recipe')
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                      title: _recipes[index].name,
                      cookTime: _recipes[index].totalTime,
                      rating: _recipes[index].rating.toString(),
                      thumbnailUrl: _recipes[index].images);
                },
              ));
  }
}



// import 'package:flutter/material.dart';
// import '../models/recipe.api.dart';
// import '../models/recipe.dart';
// import 'widgets/recipe_card.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late List<Recipe> _recipes;
//   bool _isLoading = true;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     getRecipes();
//   }

//   Future<void> getRecipes() async {
//     try {
//       _recipes = await RecipeApi.getRecipe();
//       setState(() {
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = e.toString();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.restaurant_menu),
//             SizedBox(width: 10),
//             Text('Food Recipe'),
//           ],
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _errorMessage.isNotEmpty
//               ? Center(child: Text('Error: $_errorMessage'))
//               : ListView.builder(
//                   itemCount: _recipes.length,
//                   itemBuilder: (context, index) {
//                     return RecipeCard(
//                       title: _recipes[index].name,
//                       cookTime: _recipes[index].totalTime,
//                       rating: _recipes[index].rating.toString(),
//                       thumbnailUrl: _recipes[index].images,
//                     );
//                   },
//                 ),
//     );
//   }
// }

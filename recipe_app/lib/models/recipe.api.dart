
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'recipe.dart';

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    try {
      final response = await http.get(uri, headers: {
        "x-rapidapi-key": "a7af3dc4fdmsh4a6da9c7027e510p11ad0djsn21581f8f3443",
        "x-rapidapi-host": "yummly2.p.rapidapi.com",
        "useQueryString": "true"
      });

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        List _temp = [];

        if (data['feed'] != null) {
          for (var i in data['feed']) {
            if (i['content'] != null && i['content']['details'] != null) {
              _temp.add(i['content']['details']);
            }
          }

          return Recipe.recipesFromSnapshot(_temp);
        } else {
          throw Exception('No recipes found');
        }
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recipes: $e');
      throw Exception('Failed to load recipes');
    }
  }
}

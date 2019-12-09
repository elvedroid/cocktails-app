import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/drink_categories_filter_bloc.dart';
import 'package:cocktail_app/feature/drink_details/drink_details_view.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:cocktail_app/model/drink_category.dart';
import 'package:flutter/material.dart';

class DrinksByCategory extends StatefulWidget {
  final DrinkCategory category;

  const DrinksByCategory(this.category, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DrinksByCategoryState();
}

class DrinksByCategoryState extends State<DrinksByCategory> {
  final drinkCategoriesFilterBloc = DrinkCategoriesFilterBloc();

  @override
  void initState() {
    super.initState();
    drinkCategoriesFilterBloc.getFilteredDrinksByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrinkCategoriesFilterBloc>(
      bloc: drinkCategoriesFilterBloc,
      child: _buildResults(drinkCategoriesFilterBloc),
    );
  }
}

Widget _buildResults(DrinkCategoriesFilterBloc bloc) {
  return StreamBuilder<List<Drink>>(
    stream: bloc.drinkCategoriesFilterStream,
    builder: (context, snapshot) {
      final results = snapshot.data;

      if (results == null) {
        return Center(child: Text(''));
      }

      if (results.isEmpty) {
        return Center(child: Text('No Results'));
      }

      return _buildDrinks(results, context);
    },
  );
}

Widget _buildDrinks(List<Drink> results, BuildContext context) {
  return GridView.count(
    crossAxisCount: 2,
    children: List.generate(results.length, (index) {
      Drink drink = results[index];
      return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrinkDetails(drink)));
              },
              child: Center(
                child: FadeInImage.assetNetwork(
                    placeholderScale: 5,
                    placeholder: 'images/cocktail_anim.gif',
                    image: drink.strDrinkThumb),
              ),
            ),
            Positioned(
              height: 50,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Color(0x88000000),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(drink.strDrink,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 15.0,
                        )),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Color(0x88000000),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.shopping_cart,
                      color: Color(0xfff56040), size: 28),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 36,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.favorite_border,
                    color: Color(0xfff2003c), size: 28),
              ),
            ),
          ]);
    }),
  );
}

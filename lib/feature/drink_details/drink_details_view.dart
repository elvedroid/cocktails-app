import 'dart:math';

import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/drink_details_block.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DrinkDetails extends StatefulWidget {
  final Drink drink;

  const DrinkDetails(this.drink, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DrinkDetailsState();
}

class DrinkDetailsState extends State<DrinkDetails>
    with SingleTickerProviderStateMixin {
  final drinkDetailsBloc = DrinkDetailsBloc();

  @override
  void initState() {
    super.initState();
    drinkDetailsBloc.getDrinkDetails(widget.drink);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrinkDetailsBloc>(
      bloc: drinkDetailsBloc,
      child: _buildResults(drinkDetailsBloc),
    );
  }
}

Widget _buildResults(DrinkDetailsBloc bloc) {
  return StreamBuilder<List<Drink>>(
    stream: bloc.drinkDetailsStream,
    builder: (context, snapshot) {
      final results = snapshot.data;

      if (results == null) {
        return Center(child: Text(''));
      }

      if (results.isEmpty) {
        return Center(child: Text('No Results'));
      }

      return _buildDrinkDetails(results);
    },
  );
}

Widget _buildDrinkDetails(List<Drink> results) {
  var drink = results[0];

  return Container(
    color: Color(0xffF5F2E8),
    child: ListView(children: <Widget>[
      _buildDetailImageCard(drink),
      _buildTabBar(drink),
    ]),
  );
}

Widget _buildDetailImageCard(Drink drink) {
  return Card(
    color: Color(0xffF5F2E8),
    child: FadeInImage.assetNetwork(
        height: 220,
        placeholderScale: 5,
        fit: BoxFit.cover,
        placeholder: 'images/cocktail_anim.gif',
        image: drink.strDrinkThumb),
  );
}

Widget _buildTabBar(Drink drink) {
  return DefaultTabController(
    length: 2,
    child: Column(
      children: <Widget>[
        _buildTabBars(drink),
        _buildTabBarView(drink),
      ],
    ),
  );
}

Widget _buildTabBars(Drink drink) {
  return Container(
    color: Colors.white,
    child: TabBar(
      tabs: [
        Tab(
            icon: Text(
          "Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )),
        Tab(
          icon: Text(
            "User Reviews",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTabBarView(Drink drink) {
  return Container(
    height: 3000,
    child: TabBarView(
      children: [
        _buildTabBarDetail(drink),
        Container(
//          alignment: AlignmentDirectional.center,
          height: 300,
          child: Text(
            'No Reviews',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

_buildTabBarDetail(Drink drink) {
  return Column(children: <Widget>[
    _buildDrinkInfoCard(drink),
    _buildIngredientsCard(drink),
    _buildDrinkBarsInfo(drink),
  ]);
}

Widget _buildDrinkInfoCard(Drink drink) {
  return Card(
    margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Category:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              drink.strCategory,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Glass:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              drink.strGlass,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Alcoholic: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            (drink.strAlcoholic == 'Alcoholic'
                ? Icon(
                    Icons.check,
                    color: Colors.lightGreen,
                  )
                : Icon(
                    Icons.close,
                    color: Color(0xfff2003c),
                  )),
          ],
        ),
      ],
    ),
  );
}

Widget _buildIngredientsCard(Drink drink) {
  var ingredients = drink.strIngredients;
  var measurements = drink.strMeasures;
  var instructions = drink.strInstructions;
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
          child: Text(
            "Ingredients",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: List<int>.generate(ingredients.length, (i) => i + 1)
                .map((index) => Text(
                      ingredients[index - 1] +
                          (measurements.length > index - 1
                              ? " - " + measurements[index - 1]
                              : ""),
                      style: TextStyle(color: Colors.black),
                    ))
                .toList(),
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
              child: Text(
                "Instructions",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          child: Text(
            instructions,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDrinkBarsInfo(Drink drink) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List<int>.generate(6, (i) => i + 1)
          .map((index) => _buildDrinkPerBarInfo(drink, index))
          .toList(),
    ),
  );
}

Widget _buildDrinkPerBarInfo(Drink drink, int index) {
  var random = Random();
  var ratingAtBar = random.nextInt(4) + random.nextDouble();
  return Container(
    decoration: BoxDecoration(
      border: (index == 6
          ? null
          : Border(
              bottom: BorderSide(
                color: Color(0xffF5F2E8),
              ),
            )),
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Bar ${index}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Icon(Icons.favorite_border),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Text(
                "Drink Rating:",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 8),
              child: SmoothStarRating(
                rating: ratingAtBar,
                borderColor: Colors.black,
                color: Colors.yellow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
              child: Text(
                ratingAtBar.toStringAsFixed(1),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            FlatButton(
              child: Text("Leave a comment"),
              onPressed: () => {},
            ),
          ],
        ),
      ],
    ),
  );
}

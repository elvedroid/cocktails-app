import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/drink_details_block.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:flutter/material.dart';

class DrinkDetails extends StatefulWidget {
  final Drink drink;

  const DrinkDetails(this.drink, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DrinkDetailsState();
}

class DrinkDetailsState extends State<DrinkDetails> {
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
      _buildDrinkInfoCard(drink),
      _buildIngredientsCard(drink),
      _buildDrinkBarsInfo(drink),
    ]),
  );
}

Card _buildDetailImageCard(Drink drink) {
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

Card _buildDrinkInfoCard(Drink drink) {
  return Card(
    margin: const EdgeInsets.fromLTRB(16, 16, 8.0, 16),
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

Card _buildIngredientsCard(Drink drink) {
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
          padding: const EdgeInsets.fromLTRB(
            8,
            16,
            8,
            4,
          ),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(
            8,
            16,
            8,
            4,
          ),
          child: Text(
            "Instructions",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            8,
            0,
            8,
            16,
          ),
          child: Text(
            instructions,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
  );
}

Padding _buildDrinkBarsInfo(Drink drink) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildDrinkPerBarInfo(drink),
      ],
    ),
  );
}

Card _buildDrinkPerBarInfo(Drink drink) {
  return Card(
    child: Text("Bar1"),
  );
}

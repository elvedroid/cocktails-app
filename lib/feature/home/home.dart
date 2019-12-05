import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/drink_query_bloc.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  final drinkQueryBloc = DrinkQueryBloc();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<DrinkQueryBloc>(
        bloc: drinkQueryBloc,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a location'),
                onChanged: (query) => drinkQueryBloc.submitQuery(query),
              ),
            ),
            Expanded(
              child: _buildResults(drinkQueryBloc),
            )
          ],
        ));
  }

  @override
  void dispose() {
    drinkQueryBloc.dispose();
    super.dispose();
  }
}

Widget _buildResults(DrinkQueryBloc bloc) {
  return StreamBuilder<List<Drink>>(
    stream: bloc.searchDrinksStream,
    builder: (context, snapshot) {
      // 1
      final results = snapshot.data;

      if (results == null) {
        return Center(child: Text('Enter a drink'));
      }

      if (results.isEmpty) {
        return Center(child: Text('No Results'));
      }

      return _buildSearchResults(results);
    },
  );
}

Widget _buildSearchResults(List<Drink> results) {
  return ListView.separated(
    itemCount: results.length,
    separatorBuilder: (BuildContext context, int index) => Divider(),
    itemBuilder: (context, index) {
      final drink = results[index];
      return ListTile(
        title: Text(drink.strDrink),
        onTap: () {},
      );
    },
  );
}

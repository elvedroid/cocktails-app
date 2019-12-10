import 'package:cocktail_app/bloc/bloc_provider.dart';
import 'package:cocktail_app/bloc/drink_query_bloc.dart';
import 'package:cocktail_app/model/drink.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  final ValueChanged<Drink> onPush;

  const SearchView({Key key, this.onPush}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  final drinkQueryBloc = DrinkQueryBloc();

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
//    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrinkQueryBloc>(
        bloc: drinkQueryBloc,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                focusNode: _focusNode,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    helperStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Enter a cocktail name'),
                onChanged: (query) => drinkQueryBloc.submitQuery(query),
              ),
            ),
            Expanded(
              child: _buildResults(drinkQueryBloc, widget.onPush),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    drinkQueryBloc.dispose();
    super.dispose();
  }
}

Widget _buildResults(DrinkQueryBloc bloc, onPush) {
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

      return _buildSearchResults(results, onPush);
    },
  );
}

Widget _buildSearchResults(List<Drink> results, onPush) {
  return ListView.separated(
    itemCount: results.length,
    separatorBuilder: (BuildContext context, int index) => Divider(),
    itemBuilder: (context, index) {
      final drink = results[index];
      return ListTile(
        title: Text(
          drink.strDrink,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onTap: () {
          onPush(drink);
        },
      );
    },
  );
}

class Drink {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;
  final String strCategory;

  final List strIngredients;
  final List strMeasures;

  final String strInstructions;
  final String strGlass;
  final String strAlcoholic;

  Drink({
    this.idDrink,
    this.strDrink,
    this.strDrinkThumb,
    this.strCategory,
    this.strIngredients,
    this.strMeasures,
    this.strInstructions,
    this.strGlass,
    this.strAlcoholic});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
        idDrink: json['idDrink'],
        strDrink: json['strDrink'],
        strDrinkThumb: json['strDrinkThumb'],
        strCategory: json['strCategory'],
        strIngredients: json['strIngredients'],
        strMeasures: json['strMeasures'],
        strInstructions: json['strInstructions'],
        strGlass: json['strGlass'],
        strAlcoholic: json['strAlcoholic']
    );
  }
}

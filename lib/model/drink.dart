class Drink {
  final String idDrink;
  final String strDrink;
  final String strCategory;
  final String strMeasure1;
  final String strMeasure2;
  final String strMeasure3;
  final String strIngredient1;
  final String strIngredient2;
  final String strIngredient3;
  final String strIngredient4;
  final String strInstructions;
  final String strGlass;
  final String strAlcoholic;
  final String dateModified;

  Drink(
      {this.idDrink,
      this.strDrink,
      this.strCategory,
      this.strMeasure1,
      this.strMeasure2,
      this.strMeasure3,
      this.strIngredient1,
      this.strIngredient2,
      this.strIngredient3,
      this.strIngredient4,
      this.strInstructions,
      this.strGlass,
      this.strAlcoholic,
      this.dateModified});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
        idDrink: json['idDrink'],
        strDrink: json['strDrink'],
        strCategory: json['strCategory'],
        strMeasure1: json['strMeasure1'],
        strMeasure2: json['strMeasure2'],
        strMeasure3: json['strMeasure3'],
        strIngredient1: json['strIngredient1'],
        strIngredient2: json['strIngredient2'],
        strIngredient3: json['strIngredient3'],
        strInstructions: json['strInstructions'],
        strGlass: json['strGlass'],
        strAlcoholic: json['strAlcoholic'],
        dateModified: json['dateModified']);
  }
}

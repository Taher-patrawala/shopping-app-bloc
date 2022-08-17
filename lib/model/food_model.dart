class FoodModel {
  int? id;
  String? name;
  String? ingredients;
  String? imageLink;
  late String error;

  // FoodModel({required this.name,required this.ingredients, this.imageLink});

  FoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['title'];
    ingredients = json['description'];
    imageLink = json['image'];
  }

  FoodModel.withError(String errorMessage) {
    error = errorMessage;
  }
}

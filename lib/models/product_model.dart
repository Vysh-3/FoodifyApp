class ProductModel {
  late final String image;
  late final String title;
  late final String description;
  late double price;
  int quantity;

  ProductModel({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
  });
}
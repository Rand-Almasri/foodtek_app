class CartItem {
  String name;
  String restaurant;
  double price;
  String image;
  int quantity;

  CartItem({
    required this.name,
    required this.restaurant,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}
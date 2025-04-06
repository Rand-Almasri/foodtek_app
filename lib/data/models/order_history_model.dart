
class OrderHistoryModel {
  final String id;
  final String name;
  final String restaurant;
  final double price;
  final String imagePath;
  final String date;

  OrderHistoryModel({
    required this.id,
    required this.name,
    required this.restaurant,
    required this.price,
    required this.imagePath,
    required this.date,
  });

  // Factory constructor to create from JSON
  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'],
      name: json['name'],
      restaurant: json['restaurant'],
      price: json['price'].toDouble(),
      imagePath: json['imagePath'],
      date: json['date'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'restaurant': restaurant,
      'price': price,
      'imagePath': imagePath,
      'date': date,
    };
  }
}
class Items {
  final String category;
  final String name;
  final double price;
  final DateTime date;

  Items({
    required this.category,
    required this.name,
    required this.price,
    required this.date,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
        category: json['category'],
        name: json['name'],
        price: double.parse(json['price']),
        date: DateTime.parse(json['date']));
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'name': name,
        'price': price.toString(),
        'date': date.toString(),
      };
}

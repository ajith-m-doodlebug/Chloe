class UserClass {
  final String name;
  final String email;
  final String password;
  final String userID;
  final double budget;
  final double remaining;
  final double limit;

  UserClass({
    required this.name,
    required this.email,
    required this.password,
    required this.userID,
    required this.budget,
    required this.remaining,
    required this.limit,
  });

  UserClass.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        password = json['password'],
        userID = json['userID'],
        budget = double.parse(json['budget']),
        remaining = double.parse(json['remaining']),
        limit = double.parse(json['limit']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'userID': userID,
        'budget': budget.toString(),
        'remaining': remaining.toString(),
        'limit': limit.toString(),
      };
}

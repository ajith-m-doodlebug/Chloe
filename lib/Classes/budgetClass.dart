class Budget {
  double totalBudget;
  double spendBudget;
  double remainingBudget;
  double limit;

  Budget({
    required this.totalBudget,
    required this.spendBudget,
    required this.remainingBudget,
    required this.limit,
  });

  Budget.fromJson(Map<String, dynamic> json)
      : totalBudget = double.parse(json['totalBudget']),
        spendBudget = double.parse(json['spendBudget']),
        remainingBudget = double.parse(json['remainingBudget']),
        limit = double.parse(json['limit']);

  Map<String, dynamic> toJson() => {
        'totalBudget': totalBudget.toString(),
        'spendBudget': spendBudget.toString(),
        'remainingBudget': remainingBudget.toString(),
        'limit': limit.toString(),
      };
}

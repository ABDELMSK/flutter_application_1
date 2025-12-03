import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  String type; // "income" | "expense"

  @HiveField(1)
  double amount;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime date;

  TransactionModel({
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });
}

import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/hive_service.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  TransactionProvider() {
    loadTransactions();
  }

  void loadTransactions() {
    final box = HiveService.getBox();
    _transactions = box.values.toList();
    notifyListeners();
  }

  void addTransaction(TransactionModel t) {
    final box = HiveService.getBox();
    box.add(t);
    _transactions.add(t);
    notifyListeners();
  }

  double get totalIncome => _transactions
      .where((t) => t.type == "income")
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpense => _transactions
      .where((t) => t.type == "expense")
      .fold(0.0, (sum, t) => sum + t.amount);

  double get balance => totalIncome - totalExpense;
}

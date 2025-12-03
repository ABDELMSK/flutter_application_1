import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/firebase_service.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  TransactionProvider() {
    loadTransactions();
  }

  void loadTransactions() {
    // Listen to Firebase stream
    FirebaseService.getTransactionsStream().listen((transactions) {
      _transactions = transactions;
      notifyListeners();
    });
  }

  Future<void> addTransaction(TransactionModel t) async {
    // Add to Firebase
    await FirebaseService.addTransaction(t);
    // The stream will automatically update _transactions
  }

  double get totalIncome => _transactions
      .where((t) => t.type == "income")
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpense => _transactions
      .where((t) => t.type == "expense")
      .fold(0.0, (sum, t) => sum + t.amount);

  double get balance => totalIncome - totalExpense;
}
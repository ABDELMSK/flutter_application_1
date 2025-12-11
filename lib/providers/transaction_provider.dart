import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/transaction_model.dart';
import '../services/firebase_service.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  StreamSubscription<List<TransactionModel>>? _transactionSubscription;
  StreamSubscription<User?>? _authSubscription;
  String? _currentUserId;

  List<TransactionModel> get transactions => _transactions;

  TransactionProvider() {
    // Listen to auth state changes
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user?.uid != _currentUserId) {
        // User changed, reset data
        _currentUserId = user?.uid;
        _resetData();
        if (user != null) {
          loadTransactions();
        }
      }
    });
  }

  void _resetData() {
    // Cancel existing subscription
    _transactionSubscription?.cancel();
    _transactionSubscription = null;
    
    // Clear transactions
    _transactions = [];
    notifyListeners();
  }

  void loadTransactions() {
    // Cancel any existing subscription
    _transactionSubscription?.cancel();
    
    // Listen to Firebase stream for current user
    _transactionSubscription = FirebaseService.getTransactionsStream().listen((transactions) {
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

  @override
  void dispose() {
    _transactionSubscription?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }
}
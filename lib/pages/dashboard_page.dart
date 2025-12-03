import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import 'add_expense_page.dart';
import 'add_income_page.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Gestion Financière")),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Solde : ${provider.balance} MAD",
                    style: const TextStyle(fontSize: 24)),
                Text("Revenus : ${provider.totalIncome} MAD",
                    style: const TextStyle(color: Colors.green)),
                Text("Dépenses : ${provider.totalExpense} MAD",
                    style: const TextStyle(color: Colors.red)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (_, i) {
                final t = provider.transactions[i];
                return ListTile(
                  leading: Icon(
                    t.type == "income"
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: t.type == "income" ? Colors.green : Colors.red,
                  ),
                  title: Text("${t.amount} MAD"),
                  subtitle: Text(t.description),
                  trailing:
                      Text(DateFormat('dd/MM/yyyy').format(t.date)),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "income",
            backgroundColor: Colors.green,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddIncomePage())),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "expense",
            backgroundColor: Colors.red,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddExpensePage())),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

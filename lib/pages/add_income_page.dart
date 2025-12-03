import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class AddIncomePage extends StatelessWidget {
  AddIncomePage({super.key});

  final amountCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un revenu")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Montant"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<TransactionProvider>(context, listen: false);

                provider.addTransaction(TransactionModel(
                  type: "income",
                  amount: double.parse(amountCtrl.text),
                  description: descCtrl.text,
                  date: DateTime.now(),
                ));

                Navigator.pop(context);
              },
              child: const Text("Ajouter"),
            )
          ],
        ),
      ),
    );
  }
}

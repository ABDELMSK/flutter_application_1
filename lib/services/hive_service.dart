import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';

class HiveService {
  static const boxName = "transactions";

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TransactionModelAdapter());
    await Hive.openBox<TransactionModel>(boxName);
  }

  static Box<TransactionModel> getBox() {
    return Hive.box<TransactionModel>(boxName);
  }
}

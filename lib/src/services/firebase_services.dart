import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  // Fetch Excprense List
  getExprenseList() {
    return FirebaseFirestore.instance.collection('expenseList').snapshots();
  }

  // Set Exprense Data
  Future addExpenseData(
      {required title,
      required description,
      required price,
      required image}) async {
    await FirebaseFirestore.instance
        .collection('expenseList')
        .doc(DateTime.now().toIso8601String().toString())
        .set({
      "title": title,
      "description": description,
      "price": price,
      "date_time": DateTime.now().toString(),
      "image_url": image
    });
  }
}

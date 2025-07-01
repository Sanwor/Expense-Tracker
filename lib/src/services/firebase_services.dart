import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  // Fetch Excprense List
  getExpenseList() {
    return FirebaseFirestore.instance.collection('expenseList').snapshots();
  }

  // Set Exprense Data
  Future addExpenseData(
      {required title,
      required description,
      required price,
      required image,
      required millisecond}) async {
    await FirebaseFirestore.instance
        .collection('expenseList')
        .doc(millisecond)
        .set({
      "title": title,
      "description": description,
      "price": price,
      "date_time": millisecond,
      "image_url": image
    });
  }
}

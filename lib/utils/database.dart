import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection("Customers");
final CollectionReference _emiHistory = _firestore.collection("History");

class Database {
  // Read one customer's data
  static Stream<QuerySnapshot> readOne({required String uid}) {
    return FirebaseFirestore.instance
        .collection("Customers")
        .where("imei", isEqualTo: uid)
        .snapshots();
  }

  static Stream<QuerySnapshot> showEmiHistory({required String uid}) {
    return FirebaseFirestore.instance
        .collection("History")
        .where("cusId", isEqualTo: uid)
        .snapshots();
  }

  //Update Customer's data
  static Future<void> updateItem({
    required double emiPaid,
    required double amountPaid,
    required double remAmount,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection("Customers").doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "emi_paid": emiPaid,
      "amount_paid": amountPaid,
      "rem_amount": remAmount,
      "lastDue": DateTime.now()
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  // Delete any customer's File
  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection("Customers").doc(docId);
    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }

  // Read All Customer's Data
  static Stream<QuerySnapshot> readItem() {
    return FirebaseFirestore.instance.collection("Customers").snapshots();
  }

  // ReadDataWithFilter
  static Stream<QuerySnapshot> readDataWithFilter(
      {required String fMode, bCode}) {
    return FirebaseFirestore.instance
        .collection("Customers")
        .where("financeMode", isEqualTo: fMode)
        .where("branch_code", isEqualTo: bCode)
        .snapshots();
  }

  static Future<void> addEmiHistory({
    required double emi,
    required String cusId,
  }) async {
    DocumentReference documentReference = _emiHistory.doc();
    Map<String, dynamic> data = <String, dynamic>{
      'emi': emi,
      'date': DateTime.now(),
      'cusId': cusId,
    };
    await documentReference
        .set(data)
        .whenComplete(() => print("Customer Added  ------------"))
        .catchError((e) => print(
            e + "Error -----------------------------------------------------"));
  }

  //Add Customer

  // ignore: non_constant_identifier_names
  static Future<void> add_customer_Model({
    required String name,
    // ignore: non_constant_identifier_names
    required String phone_no,
    required String email,
    required String address,
    // ignore: non_constant_identifier_names
    required String loan_id,
    required String model,
    // ignore: non_constant_identifier_names
    required String branch_code,
    required String imei,
    // ignore: non_constant_identifier_names
    required String ref_name,
    // ignore: non_constant_identifier_names
    required String ref_phone_no,
    required String profile,
    // ignore: non_constant_identifier_names
    required String adhaar_front,
    // ignore: non_constant_identifier_names
    required String adhaar_back,
    // ignore: non_constant_identifier_names
    required String pan_photo,
    // ignore: non_constant_identifier_names
    required double file_charge,
    required double dp,
    required double price,
    required double duration,
    required String description,
    required String financeMode,
  }) async {
    DocumentReference documentReference = _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      'name': name,
      'phone_no': phone_no,
      'email': email,
      'address': address,
      'loan_id': loan_id,
      'model': model,
      'branch_code': branch_code,
      'imei': imei,
      'duration': (duration).toDouble(),
      'ref_name': ref_name,
      'ref_phone_no': ref_phone_no,
      'profile': profile,
      'adhaar_front': adhaar_front,
      'adhaar_back': adhaar_back,
      'pan_photo': pan_photo,
      'file_charge': (file_charge).toDouble(),
      'dp': (dp).toDouble(),
      'price': (price).toDouble(),
      'total_due': (price + file_charge - dp).toDouble(),
      'emi': ((price + file_charge - dp) / duration).toDouble(),
      'emi_paid': 0.0,
      'amount_paid': 0.0,
      'rem_amount': (price + file_charge - dp).toDouble(),
      'date': DateTime.now(),
      'lastDue': DateTime.now(),
      'description': description,
      'financeMode': financeMode,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Customer Added  ------------"))
        .catchError((e) => print(
            e + "Error -----------------------------------------------------"));
  }
}

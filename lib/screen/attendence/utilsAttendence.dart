import 'package:cloud_firestore/cloud_firestore.dart';

class UtilsAttendence {
  static Future<String> futureName(data) async {
    Firestore firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore
        .collection('user')
        .where(
          "nrp",
          isEqualTo: data,
        )
        .getDocuments();
    return snapshot.documents[0].data['name'];
  }
}

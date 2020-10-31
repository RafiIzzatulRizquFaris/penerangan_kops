import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/contract/absensi_contract.dart';

class AbsensiPresenter implements AbsensiContractPresenter {
  AbsensiContractView _absensiContractView;
  Firestore firestore = Firestore.instance;

  AbsensiPresenter(this._absensiContractView);

  @override
  Future<List<DocumentSnapshot>> getAbsensiData(String date) async {
    QuerySnapshot snapshot = await firestore
        .collection('presensi')
        .where(
          "date",
          isEqualTo: date,
        )
        .getDocuments();
    return snapshot.documents;
  }

  @override
  Future<List<DocumentSnapshot>> getSummary() async {
    QuerySnapshot snapshot =
        await firestore.collection('presensi')
        .orderBy("date", descending: true )
        .getDocuments();
    return snapshot.documents;
  }

  @override
  loadAbsensiData(String date) {
    getAbsensiData(date)
        .then((value) => _absensiContractView.setAbsensiData(value))
        .catchError((error) => _absensiContractView.setOnErrorAbsensi(error));
  }

  @override
  loadSummaryData() {
    getSummary()
        .then((value) => _absensiContractView.setAbsensiData(value))
        .catchError((error) => _absensiContractView.onErrorAbsen(error));
  }

  @override
  Future<String> getAbsen(
      String id, String name, String time, String range, String date) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('presensi')
        .where(
          "date",
          isEqualTo: date,
        )
        .where(
          "user-id",
          isEqualTo: id,
        )
        .getDocuments();
    if (querySnapshot.documents.length == 0) {
      CollectionReference collectionReference =
          firestore.collection('presensi');
      DocumentReference documentReference =
          await collectionReference.add(<String, dynamic>{
        'date': date,
        'range': range,
        'time': time,
        'nrp': id,
      });
      if (documentReference.documentID != null) {
        return AbsenResponse.SUCCESS;
      } else {
        return AbsenResponse.FAILED;
      }
    } else {
      return AbsenResponse.ALREADY;
    }
  }

  @override
  loadAbsen(String id, String name, String time, String range, String date) {
    getAbsen(id, name, time, range, date)
        .then((value) => _absensiContractView.onSuccessAbsen(value))
        .catchError((error) => _absensiContractView.onErrorAbsen(error));
  }
}

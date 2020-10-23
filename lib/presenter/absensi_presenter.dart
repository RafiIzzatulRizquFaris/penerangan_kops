import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penerangan_kops/contract/absensi_contract.dart';

class AbsensiPresenter implements AbsensiContractPresenter{

  AbsensiContractView _absensiContractView;

  AbsensiPresenter(this._absensiContractView);

  @override
  Future<List<DocumentSnapshot>>getAbsensiData(String date) async {
    Firestore firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore.collection('presensi').where("date", isEqualTo: date,).getDocuments();
    return snapshot.documents;
  }

  @override
  loadAbsensiData(String date) {
    getAbsensiData(date).then((value) => _absensiContractView.setAbsensiData(value)).catchError((error) => _absensiContractView.setOnErrorAbsensi(error));
  }

  @override
  getAbsen(String id, String name, String time, String range, String date) {
    // TODO: implement getAbsen
    throw UnimplementedError();
  }

  @override
  loadAbsen(String id, String name, String time, String range, String date) {
    // TODO: implement loadAbsen
    throw UnimplementedError();
  }
  
}
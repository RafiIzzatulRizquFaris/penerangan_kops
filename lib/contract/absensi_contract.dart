import 'package:cloud_firestore/cloud_firestore.dart';

class AbsensiContractView{
  setAbsensiData(List<DocumentSnapshot> value) {}
  onSuccessAbsen(String status) {}
  setOnErrorAbsensi(error) {}
  onErrorAbsen(error){}
}

class AbsensiContractPresenter{
  getAbsensiData (String date){}
  loadAbsensiData (String date){}
  getAbsen (String id, String name, String time, String range, String date){}
  loadAbsen (String id, String name,  String time, String range, String date){}
}
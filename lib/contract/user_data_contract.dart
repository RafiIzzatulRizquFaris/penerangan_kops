import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataContractView {
  onSuccessUserData(List<DocumentSnapshot> value) {}
  onErrorUserData(error) {}
  onSuccess(String value) {}
}

class UserDataContractPresenter {
  getUserData() {}
  loadUserData() {}
  addUserData(String name, String nrp, String pangkat, String password, String satuan, String telephone) {}
  addingUserdata(String name, String nrp, String pangkat, String password, String satuan, String telephone) {}
  deleteUserData(String nrp) {}
  deletingUserData(String nrp) {}
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataContractView {
  onSuccessUserData(List<DocumentSnapshot> value) {}
  onErrorUserData(error) {}
  onSuccessDelete(String value) {}
}

class UserDataContractPresenter {
  getUserData() {}
  loadUserData() {}

  deleteUserData(String nrp) {}
  deletingUserData(String nrp) {}
}

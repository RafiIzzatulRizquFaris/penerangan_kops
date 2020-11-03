import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penerangan_kops/contract/user_data_contract.dart';

class UserDataPresenter implements UserDataContractPresenter {
  UserDataContractView _userDataContractView;
  Firestore firestore = Firestore.instance;
  UserDataPresenter(this._userDataContractView);

  @override
  Future<List<DocumentSnapshot>> getUserData() async {
    QuerySnapshot snapshot = await firestore.collection('user').getDocuments();
    return snapshot.documents;
  }

  @override
  Future<String> deleteUserData(String nrp) async {
    if (nrp != "1434236") {
      QuerySnapshot snapshot = await firestore
          .collection('user')
          .where("nrp", isEqualTo: nrp)
          .getDocuments();

      if (snapshot.documents.isNotEmpty) {
        await firestore
            .collection('user')
            .document(snapshot.documents[0].documentID)
            .delete();
        return "sucess";
      }
    }
    return "failed";
  }

  @override
  Future<String> addUserData(String name, String nrp, String pangkat,
      String password, String satuan, String telephone) async {
    CollectionReference collectionReference = firestore.collection('user');
    DocumentReference documentReference =
        await collectionReference.add(<String, dynamic>{
      'isadmin': "0",
      'name': name,
      'nrp': nrp,
      'pangkat': pangkat,
      'password': password,
      'satuan': satuan,
      'telephone': telephone
    });
    if (documentReference.documentID != null) {
      return "success";
    } else {
      return "Failed";
    }
  }

  @override
  loadUserData() {
    getUserData()
        .then((value) => _userDataContractView.onSuccessUserData(value))
        .catchError((error) => _userDataContractView.onErrorUserData(error));
  }

  @override
  deletingUserData(String nrp) {
    deleteUserData(nrp)
        .then((value) => _userDataContractView.onSuccess(value))
        .catchError((error) => _userDataContractView.onErrorUserData(error));
  }

  @override
  addingUserdata(String name, String nrp, String pangkat, String password,
      String satuan, String telephone) {
    addUserData(name, nrp, pangkat, password, satuan, telephone)
        .then((value) => _userDataContractView.onSuccess(value))
        .catchError((error) => _userDataContractView.onErrorUserData(error));
  }
}

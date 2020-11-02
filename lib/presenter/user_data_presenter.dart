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

    return "failed";
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
        .then((value) => _userDataContractView.onSuccessDelete(value))
        .catchError((error) => _userDataContractView.onErrorUserData(error));
  }
}

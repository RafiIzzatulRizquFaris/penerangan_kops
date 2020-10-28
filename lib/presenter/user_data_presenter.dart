import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penerangan_kops/contract/user_data_contract.dart';

class UserDataPresenter implements UserDataContractPresenter {
  UserDataContractView _userDataContractView;

  UserDataPresenter(this._userDataContractView);

  @override
  Future<List<DocumentSnapshot>> getUserData() async {
    Firestore firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore.collection('user').getDocuments();
    return snapshot.documents;
  }

  @override
  loadUserData() {
    getUserData()
        .then((value) => _userDataContractView.onSuccessUserData(value))
        .catchError((error) => _userDataContractView.onErrorUserData(error));
  }
}

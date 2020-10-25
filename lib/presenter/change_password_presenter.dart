import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penerangan_kops/contract/change_password_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ChangePasswordPresenter implements ChangePasswordContractPresenter{
  ChangePasswordContractView _changePasswordContractView;
  Firestore firestore = Firestore.instance;
  SharedPreferences preferences;

  ChangePasswordPresenter(this._changePasswordContractView);

  @override
  Future<String> getPasswordData(String password) async {
    preferences = await SharedPreferences.getInstance();
    String did = preferences.get(PreferenceKey.documentId).toString();
    DocumentReference documentReference = firestore.document('user/$did');
    firestore.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot = await transaction.get(documentReference);
      if (documentSnapshot.exists){
        await transaction.update(documentReference, <String, dynamic>{
          'password': password,
        });
      } else {
        return "failed";
      }
    });
    return "success";
  }

  @override
  loadPasswordData(String password) {
    getPasswordData(password).then((value) => _changePasswordContractView.onSuccessChangePassword(value)).catchError((error) => _changePasswordContractView.onErrorChangePassword(error));
  }
}
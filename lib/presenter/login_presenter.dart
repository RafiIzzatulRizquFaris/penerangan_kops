import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/contract/login_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPresenter implements LoginContractPresenter{

  LoginContractView _loginContractView;

  LoginPresenter(this._loginContractView);

  @override
  Future<String> getLoginData (String id, String password) async {
    final Firestore _firestore = Firestore.instance;
    QuerySnapshot snapshot = await _firestore
        .collection('user')
        .where("id", isEqualTo: id, )
        .getDocuments();
    if (snapshot.documents.length == 1){
      String dataPw = snapshot.documents[0].data["password"];
      if (dataPw.toString() == password){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString(PreferenceKey.id, snapshot.documents[0].data[PreferenceKey.id].toString());
        await preferences.setString(PreferenceKey.name, snapshot.documents[0].data[PreferenceKey.name].toString());
        await preferences.setString(PreferenceKey.password, snapshot.documents[0].data[PreferenceKey.password].toString());
        return LoginResponse.SUCCESS;
      } else {
        return LoginResponse.WRONG_PASSWORD;
      }
    }else {
      return LoginResponse.FAILED;
    }
  }

  @override
  loadLoginData(String id, String password) {
    getLoginData(id, password).then((value) => _loginContractView.setLoginData(value)).catchError((error) => _loginContractView.setOnErrorLogin(error));
  }

}
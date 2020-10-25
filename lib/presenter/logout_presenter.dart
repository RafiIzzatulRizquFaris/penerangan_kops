import 'package:penerangan_kops/contract/logout_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutPresenter implements LogoutContractPresenter{

  LogoutContractView _logoutContractView;
  SharedPreferences preferences;

  LogoutPresenter(this._logoutContractView);

  @override
  Future<String> getLogoutData() async{
    preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    return "success";
  }

  @override
  loadLogoutData() {
    getLogoutData().then((value) => _logoutContractView.onSuccessLogout(value)).catchError((error) => _logoutContractView.onErrorLogout(error));
  }

}
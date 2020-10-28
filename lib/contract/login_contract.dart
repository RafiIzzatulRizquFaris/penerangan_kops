class LoginContractView {
  setLoginData(List<String> response) {}
  setOnErrorLogin(error) {}
}

class LoginContractPresenter {
  getLoginData (String id, String password){}
  loadLoginData (String id, String password){}
}
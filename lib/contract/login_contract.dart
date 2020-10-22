class LoginContractView {
  setLoginData(String status) {}
  setOnErrorLogin(error) {}
}

class LoginContractPresenter {
  getLoginData (String id, String password){}
  loadLoginData (String id, String password){}
}
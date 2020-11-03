import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penerangan_kops/constants.dart';
import 'package:penerangan_kops/contract/user_data_contract.dart';
import 'package:penerangan_kops/presenter/user_data_presenter.dart';

class AddUser extends StatefulWidget {
  AddUser({Key key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> implements UserDataContractView {
  UserDataPresenter _userDataPresenter;
  _AddUserState() {
    _userDataPresenter = UserDataPresenter(this);
  }

  TextEditingController phoneController = new TextEditingController();
  TextEditingController nrpController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController pangkatController = new TextEditingController();
  TextEditingController satuanController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: null,
        appBar: AppBar(
          title: Text("Tambah Anggota"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'telepon',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'password',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),
                TextFormField(
                  controller: nrpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'nrp',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),
                TextFormField(
                  controller: pangkatController,
                  decoration: InputDecoration(
                    labelText: 'pangkat',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),
                TextFormField(
                  controller: satuanController,
                  decoration: InputDecoration(
                    labelText: 'satuan',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  indent: 16,
                  endIndent: 16,
                ),
                FlatButton.icon(
                  textColor: AppColor.redColor,
                  onPressed: () {
                    _userDataPresenter.addingUserdata(
                        nameController.text,
                        nrpController.text,
                        pangkatController.text,
                        passwordController.text,
                        satuanController.text,
                        phoneController.text);
                  },
                  icon: Icon(Icons.person_add, size: 24),
                  label: Text("Tambah",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                )
              ],
            ),
          ),
        ));
  }

  @override
  onErrorUserData(error) {
    print(error);
  }

  @override
  onSuccess(String value) {
    print(value);
    setState(() {
      phoneController.clear();
      nrpController.clear();
      passwordController.clear();
      nameController.clear();
      pangkatController.clear();
      satuanController.clear();
    });
  }

  @override
  onSuccessUserData(List<DocumentSnapshot> value) {
    // TODO: implement onSuccessUserData
    throw UnimplementedError();
  }
}

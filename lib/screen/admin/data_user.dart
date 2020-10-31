import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:penerangan_kops/contract/user_data_contract.dart';
import 'package:penerangan_kops/presenter/user_data_presenter.dart';
import 'package:penerangan_kops/screen/admin/pdf_preview.dart';
import '../../constants.dart';

class DataUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DataUserScreen();
  }
}

class DataUserScreen extends State<DataUser> implements UserDataContractView {
  UserDataPresenter _userDataPresenter;
  List<DocumentSnapshot> documentSnapshot = List<DocumentSnapshot>();
  var isLoading;

  DataUserScreen() {
    _userDataPresenter = UserDataPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _userDataPresenter.loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PdfPreview()));
          },
          icon: Icon(Icons.print),
          backgroundColor: AppColor.redColor,
          label: Text("Print to PDF")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColor.accentColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.article,
                      size: 100,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Data Anggota",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColor.primaryColor,
                    ),
                  )
                : documentSnapshot.isEmpty
                    ? Center(
                        child: Text(
                          "Data Anggota Kosong",
                          style: TextStyle(
                            color: AppColor.accentColor,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: documentSnapshot.length,
                        itemBuilder: itemBuilderUserData,
                      ),
          ),
        ],
      ),
    );
  }

  @override
  onErrorUserData(error) {
    print(error.toString());
  }

  @override
  onSuccessUserData(List<DocumentSnapshot> value) {
    if (value != null) {
      setState(() {
        documentSnapshot = value;
        isLoading = false;
      });
    }
  }

  Widget itemBuilderUserData(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(
          Icons.person,
          color: AppColor.blackColor,
          size: 40,
        ),
        title: Text(
          "${documentSnapshot[index].data["pangkat"]} ${documentSnapshot[index].data["name"]}",
          style: TextStyle(
            color: AppColor.blackColor,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: AppColor.redColor,
            ),
            onPressed: null),
        subtitle: Text(
          documentSnapshot[index].data["nrp"],
          style: TextStyle(color: AppColor.blackColor),
        ),
      ),
    );
  }
}

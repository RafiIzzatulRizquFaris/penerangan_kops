import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:penerangan_kops/contract/absensi_contract.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';

import 'package:penerangan_kops/presenter/absensi_presenter.dart';

import '../../constants.dart';

class PdfPreview extends StatefulWidget {
  @override
  _PdfPreviewState createState() => _PdfPreviewState();
}

class _PdfPreviewState extends State<PdfPreview>
    implements AbsensiContractView {
  String path;
  bool isLoading;
  AbsensiPresenter _absensiPresenter;
  List<DocumentSnapshot> listAttendence = List<DocumentSnapshot>();
  final pdf = pw.Document();

  final tableHeaders = [
    'NRP',
    "Nama",
    'Tanggal',
    'Jam',
  ];

  _PdfPreviewState() {
    _absensiPresenter = AbsensiPresenter(this);
  }

  // writeOnPdf();
  //           await savePdf();
  //           Directory documentDirectory =
  //               await getApplicationDocumentsDirectory();

  //           String documentPath = documentDirectory.path;
  //           String fullPath = "$documentPath/report.pdf";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    _absensiPresenter.loadSummaryData();
    print("init");
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColor.primaryColor,
              ),
            ),
          )
        : PDFViewerScaffold(
            appBar: AppBar(
              title: Text("Report"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
            path: path,
          );
  }

  @override
  onErrorAbsen(error) {
    // TODO: implement onErrorAbsen
    print(error.toString());
  }

  @override
  onSuccessAbsen(String status) {
    // TODO: implement onSuccessAbsen
    print(status.toString());
  }

  @override
  setAbsensiData(List<DocumentSnapshot> value) {
    print("get data");
    if (value != null) {
      setState(() {
        listAttendence = value;
        print("data fire : " + listAttendence[0].data["nrp"]);
        writeOnPdf();
        print("clear");
      });
    }
  }

  @override
  setOnErrorAbsensi(error) {
    // TODO: implement setOnErrorAbsensi
    print(error.toString());
  }

  writeOnPdf() async {
    print("write");
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Table.fromTextArray(
            border: null,
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              borderRadius: 2,
            ),
            headerHeight: 25,
            cellHeight: 40,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.center,
              4: pw.Alignment.centerRight,
            },
            headerStyle: pw.TextStyle(
              color: PdfColors.teal,
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
            ),
            cellStyle: const pw.TextStyle(
              color: PdfColors.teal,
              fontSize: 10,
            ),
            rowDecoration: pw.BoxDecoration(
              border: pw.BoxBorder(
                bottom: true,
                color: PdfColors.teal,
                width: .5,
              ),
            ),
            headers: List<String>.generate(
              tableHeaders.length,
              (col) => tableHeaders[col],
            ),
            data: List<List<String>>.generate(
              listAttendence.length,
              (row) => List<String>.generate(
                tableHeaders.length,
                (col) => listAttendence[row].data[indexing(col)],
              ),
            ),
          )
        ];
      },
    ));

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    path = "$documentPath/report.pdf";
    File file = File(path);

    file.writeAsBytesSync(pdf.save());
    print("$path : path");
    setState(() {
      isLoading = false;
    });
  }

  String indexing(int i){
    switch (i) {
      case 0:
        return "nrp";
        break;
      case 1: 
      return "time";
      case 2:
      return "date";
      default:
    }
  }
}

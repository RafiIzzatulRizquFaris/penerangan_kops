import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:penerangan_kops/contract/absensi_contract.dart';
import 'package:penerangan_kops/presenter/absensi_presenter.dart';
import 'package:penerangan_kops/screen/attendence/component/itemAbsensiCalendar.dart';
import 'package:penerangan_kops/screen/component/grabing.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../constants.dart';

class Attandence extends StatefulWidget {
  @override
  _AttandenceState createState() => _AttandenceState();
}

class _AttandenceState extends State<Attandence>
    implements AbsensiContractView {
  CalendarController _calendarController;
  AbsensiPresenter _absensiPresenter;
  List<DocumentSnapshot> listAbsensi = List<DocumentSnapshot>();
  Environment env = Environment();
  var isLoadData;

  _AttandenceState() {
    _absensiPresenter = AbsensiPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    isLoadData = true;
    _absensiPresenter.loadAbsensiData(env.getDateNow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnappingSheet(
        grabbingHeight: 40.0,
        snapPositions: [
          SnapPosition(
              positionPixel: MediaQuery.of(context).size.height * 25 / 100,
              snappingCurve: Curves.elasticOut,
              snappingDuration: Duration(milliseconds: 750)),
          SnapPosition(
              positionFactor: 0.75,
              snappingCurve: Curves.ease,
              snappingDuration: Duration(milliseconds: 500)),
        ],
        sheetBelow: SnappingSheetContent(
            child: Container(
              color: Colors.white,
              child: isLoadData
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColor.accentColor,
                      ),
                    )
                  : listAbsensi.isEmpty
                      ? Center(
                          child: Text(
                            "Data Absensi Kosong",
                            style: TextStyle(
                              color: AppColor.accentColor,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: listAbsensi.length,
                          itemBuilder: (BuildContext context, int index) =>
                              ItemAbsensiCalendar(listAbsensi[index]),
                        ),
            ),
            heightBehavior: SnappingSheetHeight.fit()),
        grabbing: GrabSection(),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColor.accentColor,
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SafeArea(
                    child: Text(
                      "Kalender",
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TableCalendar(
                    calendarController: _calendarController,
                    onDaySelected: onDaySelected,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                      selectedColor: AppColor.redColor,
                      weekdayStyle:
                          TextStyle().copyWith(color: AppColor.primaryColor),
                      todayColor: AppColor.redColor,
                      markersColor: AppColor.primaryColor,
                      outsideDaysVisible: false,
                    ),
                    headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle().copyWith(
                          color: AppColor.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      formatButtonTextStyle: TextStyle()
                          .copyWith(color: Colors.white, fontSize: 15.0),
                      formatButtonDecoration: BoxDecoration(
                        color: AppColor.redColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void onDaySelected(
      DateTime day, List<dynamic> events, List<dynamic> holidays) {
    setState(() {
      isLoadData = true;
    });
    String selectedDay = "${day.year}-${day.month}-${day.day}";
    _absensiPresenter.loadAbsensiData(selectedDay);
  }

  @override
  onErrorAbsen(error) {
    // TODO: implement onErrorAbsen
    throw UnimplementedError();
  }

  @override
  onSuccessAbsen(String status) {
    // TODO: implement onSuccessAbsen
    throw UnimplementedError();
  }

  @override
  setAbsensiData(List<DocumentSnapshot> value) {
    setState(() {
      listAbsensi = value;
      isLoadData = false;
    });
  }

  @override
  setOnErrorAbsensi(error) {
    print(error.toString());
  }
}

import 'package:flutter/material.dart';
import 'package:penerangan_kops/screen/component/grabing.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants.dart';

class Attandence extends StatefulWidget {
  @override
  _AttandenceState createState() => _AttandenceState();
}

class _AttandenceState extends State<Attandence> {
  CalendarController _calendarController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnappingSheet(
        grabbingHeight: 40.0,
        snapPositions: [
          SnapPosition(
              positionPixel: MediaQuery.of(context).size.height * 25/100,
              snappingCurve: Curves.elasticOut,
              snappingDuration: Duration(milliseconds: 750)
              ),
          SnapPosition(
              positionFactor: 0.75,
              snappingCurve: Curves.ease,
              snappingDuration: Duration(milliseconds: 500)),
        ],
        sheetBelow: SnappingSheetContent(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: AppColor.blackColor,
                        size: 40,
                      ),
                      title: Text(
                        "Kelelawar",
                        style: TextStyle(
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0),
                      ),
                      trailing: Text(
                        "09:10",
                        style: TextStyle(
                            fontSize: 20.0, color: AppColor.blackColor),
                      ),
                      subtitle: Text(
                        "990 M",
                        style: TextStyle(color: AppColor.blackColor),
                      ),
                    ),
                  ),
                ],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(child: Text(
                    "Kalender",
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),),
                  SizedBox(
                    height: 15,
                  ),
                  TableCalendar(
                    calendarController: _calendarController,
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
}

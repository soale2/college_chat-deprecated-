import 'package:college_chat/constants/colors.dart';
import 'package:college_chat/services/CalenderClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'chatRoomsScreen.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key key}) : super(key: key);

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  CalendarClient calendarClient = CalendarClient();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  TextEditingController _eventName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Timetable',
            style: TextStyle(
              color: WHITE,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          backgroundColor: VERY_DARK_BLUE,
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: DARK_GREYISH_BLUE,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(child: Image.asset("assets/images/circle-logo.png",height: 235,width: 235,),
                  decoration: BoxDecoration(
                      color: VERY_DARK_BLUE
                  ),
                ),
                ListTile(
                  title: Text('Conversations',style: TextStyle(fontSize: 16,color: WHITE),),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => ChatRoom()));
                  },
                ),
                ListTile(
                  title: Text('Timetable',style: TextStyle(fontSize: 16,color: WHITE),),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => CalenderScreen()));
                  },
                )
              ],
            ),
          ),
        ),
        body: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: STRONG_CYAN,
                    elevation: 5,
                    shadowColor: DARK_GREYISH_BLUE,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
                    ),
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2019, 3, 5),
                          maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            setState(() {
                              this.startTime = date;
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      'Event Start Time',
                      style: TextStyle(color: VERY_DARK_BLUE),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$startTime',style: TextStyle(
                    color: Colors.greenAccent,
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: STRONG_CYAN,
                      elevation: 5,
                      shadowColor: DARK_GREYISH_BLUE,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal:24, vertical:16),
                    ),
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2019, 3, 5),
                          maxTime: DateTime(2200, 6, 7), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            setState(() {
                              this.endTime = date;
                            });
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      'Event End Time',
                      style: TextStyle(color: VERY_DARK_BLUE),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$endTime',style: TextStyle(
                  color: Colors.greenAccent,
                  ),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                style: TextStyle(
                  color: STRONG_CYAN,
                ),

                controller: _eventName,
                decoration: InputDecoration(hintText: 'Enter Event name',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: STRONG_CYAN),),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: STRONG_CYAN),),
                hintStyle: TextStyle(
                color: STRONG_CYAN,
                )),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
                shadowColor: VERY_DARK_BLUE,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),),
              ),
                child: Text(
                  'Add to Timetable',style: TextStyle(color: VERY_DARK_BLUE),
                ),
                onPressed: () {
                  //log('add event pressed');
                  calendarClient.insert(
                    _eventName.text,
                    startTime,
                    endTime,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

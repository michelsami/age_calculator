import 'package:flutter/material.dart';

import '../app_manager/age_calculator.dart';
import '../app_manager/date_format.dart';
import '../models/age_model.dart';
import '../models/duration_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BuildContext context;

  AgeModel userAge = AgeModel();

  DurationNextBirthday _nextBirthDay = DurationNextBirthday();

  final TextEditingController _dateOfBirthController =
      TextEditingController(text: "01-01-2010");

  final TextEditingController _todayDateController =
      TextEditingController(text: "01-01-2020");

  DateTime? dateOfBirth;

  DateTime? dateOfToday;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    Widget _dateOfBirthHeading = _buildHeading("Date of Birth");
    Widget _birthDateTextField = _buildBirthDateTextField();
    Widget _todayDateHeading = _buildHeading("Today's Date");
    Widget _todayDateTextField = _buildTodayDateTextField();

    Widget _clearCalculateButtonsRow = _buildClearCalcButtonsRow();
    Widget _ageOutputHeading = _buildHeading("Age is");
    Widget _ageOutputRow = _buildAgeOutputRow();
    Widget _nextBirthDayHeading = _buildHeading("Next Birth Day in");
    Widget _nextBirthOutputRow = _buildNextBirthDayOutputRow();
    Widget _emptyBox = SizedBox(height: 20);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _dateOfBirthHeading,
            _birthDateTextField,
            _emptyBox,
            _todayDateHeading,
            _todayDateTextField,
            _emptyBox,
            _clearCalculateButtonsRow,
            _emptyBox,
            _ageOutputHeading,
            _ageOutputRow,
            _emptyBox,
            _nextBirthDayHeading,
            _nextBirthOutputRow,
          ],
        ),
      ),
    );
  }

  Widget _buildOutputField(String outputTitle, String outputData) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context!).primaryColor,
          width: 115,
          height: 30,
          child: Center(
              child: Text(
            outputTitle,
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context!).primaryColor)),
          width: 115,
          height: 30,
          child: Center(
              child: Text(
            outputData,
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
          )),
        )
      ],
    );
  }

  Widget _buildHeading(String headingTitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        headingTitle,
        style: TextStyle(fontSize: 20, color: Colors.grey),
      ),
    );
  }

  InputDecoration _getTextFieldWithCalendarIconDecoration() {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context!).primaryColor,
        ),
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context!).primaryColor)),
      suffixIcon: Icon(
        Icons.date_range,
        color: Theme.of(context!).primaryColor,
      ),
      hintText: 'Please select the date',
    );
  }

  Widget _buildBirthDateTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          showCursor: true,
          readOnly: true,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1840),
                    lastDate: DateTime.now())
                .then((date) {
              //code to handle date
              if (date == null) {
                setState(() {
                  _dateOfBirthController.text = "";
                });
              } else {
                dateOfBirth = date;
                setState(() {
                  _dateOfBirthController.text =
                      DateFormatter.dateFormatted(date!).toString();
                });
                print(date.toString());
              }
            });
          },
          controller: _dateOfBirthController,
          decoration: _getTextFieldWithCalendarIconDecoration(),
        )
      ],
    );
  }

  Widget _buildTodayDateTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          showCursor: true,
          readOnly: true,
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1940),
                    lastDate: DateTime.now())
                .then((date) {
              if (date == null) {
                setState(() {
                  _todayDateController.text = "";
                });
              } else {
                dateOfToday = date;
                setState(() {
                  _todayDateController.text =
                      DateFormatter.dateFormatted(date!).toString();
                });
                print(date.toString());
              }
            });
          },
          controller: _todayDateController,
          decoration: _getTextFieldWithCalendarIconDecoration(),
        )
      ],
    );
  }

  Widget _buildClearButton() {
    return ButtonTheme(
      minWidth: 160,
      height: 60,
      child: ElevatedButton(
        //color: Theme.of(context).primaryColor,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          setState(() {
            _todayDateController.text = "";
            _dateOfBirthController.text = "";
          });
        },
        child:
            Text('CLEAR', style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return ButtonTheme(
      minWidth: 160,
      height: 60,
      child: ElevatedButton(
        //color: Theme.of(context).primaryColor,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          setState(() {
            userAge = AgeCalculatorFunction()
                .calculateAge(dateOfBirth!, dateOfToday!);
            print(userAge);

            _nextBirthDay = AgeCalculatorFunction()
                .calculateNextBirthdayDuration(dateOfBirth!);
            print(_nextBirthDay);
          });
        },
        child: Text('CALCULATE',
            style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }

  Widget _buildClearCalcButtonsRow() {
    Widget _clearOrangeButton = _buildClearButton();
    Widget _calcOrangeButton = _buildCalculateButton();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _clearOrangeButton,
        _calcOrangeButton,
      ],
    );
  }

  Widget _buildAgeOutputRow() {
    Widget _ageYearsOutputField =
        _buildOutputField("Years", userAge.years.toString());
    Widget _ageMonthsOutputField =
        _buildOutputField("Months", userAge.months.toString());
    Widget _ageDaysOutputField =
        _buildOutputField("Days", userAge.days.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _ageYearsOutputField,
        _ageMonthsOutputField,
        _ageDaysOutputField,
      ],
    );
  }

  Widget _buildNextBirthDayOutputRow() {
    Widget _nextBirthYearsOutputField = _buildOutputField("Years", "-");
    Widget _nextBirthMonthsOutputField =
        _buildOutputField("Months", _nextBirthDay.months.toString());
    Widget _nextBirthDaysOutputField =
        _buildOutputField("Days", _nextBirthDay.days.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _nextBirthYearsOutputField,
        _nextBirthMonthsOutputField,
        _nextBirthDaysOutputField,
      ],
    );
  }
}

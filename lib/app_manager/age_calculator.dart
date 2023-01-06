import 'package:age_calculator/age_calculator.dart';

import '../models/age_model.dart';
import '../models/duration_model.dart';

class AgeCalculatorFunction {
  AgeModel calculateAge(DateTime birthday, DateTime futureDate) {
    DateDuration duration;

    //Find out your age on any given date
    duration = AgeCalculator.age(birthday, today: futureDate);
    // print('Your age is $duration');

    AgeModel userAge = AgeModel();
    userAge.years = duration.years;
    userAge.months = duration.months;
    userAge.days = duration.days;
    return userAge;
  }

  DurationNextBirthday calculateNextBirthdayDuration(DateTime birthday) {
    DateDuration duration;

    duration = AgeCalculator.timeToNextBirthday(birthday);

    DurationNextBirthday userNextBirthday = DurationNextBirthday();

    userNextBirthday.months = duration.months;
    userNextBirthday.days = duration.days;
    return userNextBirthday;
  }
}

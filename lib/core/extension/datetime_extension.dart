


extension ToSubtitleForm on DateTime{

  String get dateTimeToStringSelector{
    if( year == DateTime.now().year && month == DateTime.now().month && day == DateTime.now().day){
      return "${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
    }
    return "$day.$month.$year";
  }

  String get toSubtitleForm {
    return "$day $monthtoString, $hourWithZero:$minuteWithZero";
  }

  String get toDatetimeTitleForm{
    return "$toTitleForm, $toHourAndMinute";
  }

  String get toTitleForm{
    return "$dayWithZero $monthtoString $year";
  }

  String get toDate{
    return "$dayWithZero.$monthWithZero.$year";
  }

  String get toHourAndMinute{
    return "$hourWithZero:$minuteWithZero";
  }

  String get dayWithZero{
    if(day < 10){
      return "0$day";
    }
    else{
      return day.toString();
    }
  }
  String get monthWithZero{
    if(month < 10){
      return "0$month";
    }
    else{
      return month.toString();
    }
  }
  String get minuteWithZero{
    if(minute < 10){
      return "0$minute";
    }
    else{
      return minute.toString();
    }
  }
  String get hourWithZero{
    if(hour < 10){
      return "0$hour";
    }
    else{
      return hour.toString();
    }
  }
}

extension IntMonthToString on DateTime{
  String get monthtoString{
    switch(month){
      case 1: return "Ocak";
      case 2: return "Şubat";
      case 3: return "Mart";
      case 4: return "Nisan";
      case 5: return "Mayıs";
      case 6: return "Haziran";
      case 7: return "Temmuz";
      case 8: return "Ağustos";
      case 9: return "Eylül";
      case 10: return "Ekim";
      case 11: return "Kasım";
      case 12: return "Aralık";
      default: return "";
    }
  }
}

extension IntWeekDayToString on DateTime{
  String get weekDayToString{
    switch(weekday){
      case 0: return "Pazar";
      case 1: return "Pazartesi";
      case 2: return "Salı";
      case 3: return "Çarşamba";
      case 4: return "Perşembe";
      case 5: return "Cuma";
      case 6: return "Cumartesi";
      default: return "";
    }
  }
}

extension DateWeekdayToTableCalendarWeekday on DateTime{
}


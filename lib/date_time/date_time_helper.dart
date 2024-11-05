// convert a date time object to a string yyyyddmm
String convertDateTimeToString(DateTime dateTime){
  // year in the format yyy
  String year=dateTime.year.toString();
  // month in the format mm
  String month=dateTime.month.toString();
  if(month.length==1)
    {
      month='0$month';
    }
//day in format of dd
String day=dateTime.day.toString();
  if(day.length==1){
    day='0$day';
  }
  //final format yyyymmdd

  String yyyymmdd=year+month+day;
  return yyyymmdd;


}
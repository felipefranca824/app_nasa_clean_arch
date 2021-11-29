class DateToStringConverter {
  static String converter(DateTime date) {
    var dateSplitted = date.toString().split(" ");
    return dateSplitted.first;
  }
}

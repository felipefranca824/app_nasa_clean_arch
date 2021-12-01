class DateInputConverter {
  String format(DateTime date) {
    var dateSplitted = date.toString().split(" ");
    return dateSplitted.first;
  }
}

class DateToStringConverter {
  String convert({required DateTime date}) {
    final dateSplitted = date.toString().split(' ');
    return dateSplitted.first;
  }
}
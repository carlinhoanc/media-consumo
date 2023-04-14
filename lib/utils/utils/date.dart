class DataUtils {
  String parseDate(v) {
    if (v.isEmpty) {
      return '';
    }
    List<String> value = v.split('/');
    if (value.length < 3) {
      return '';
    }
    return value[2] + '-' + value[1] + '-' + value[0];
  }

  String parseDateReverse(v) {
    if (v.isEmpty) {
      return '';
    }
    List<String> value = v.split('-');
    if (value.length < 3) {
      return '';
    }
    return value[2] + '/' + value[1] + '/' + value[0];
  }

  String formatarData(v) {
    return ((v.day < 10) ? '0' : '') +
        v.day.toString() +
        '/' +
        ((v.month < 10) ? '0' : '') +
        v.month.toString() +
        '/' +
        v.year.toString();
  }

  String formatarDataBD(v) {
    return ((v.day < 10) ? '0' : '') +
        v.day.toString() +
        '/' +
        ((v.month < 10) ? '0' : '') +
        v.month.toString() +
        '/' +
        v.year.toString();
  }
}

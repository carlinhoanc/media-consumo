class ValueLabel {
  int value;
  String title;

  ValueLabel({this.value, this.title});

  factory ValueLabel.fromJsonIdStr(Map<String, dynamic> parsedJson) {
    return ValueLabel(
      value: parsedJson["id"],
      title: parsedJson["nome"] as String,
    );
  }

  factory ValueLabel.fromJsonIdInt(Map<String, dynamic> parsedJson) {
    if(parsedJson["id"] is int) {
      return ValueLabel(
        value: parsedJson["id"],
        title: parsedJson["nome"] as String,
      );
    }
    return ValueLabel(
      value: int.parse(parsedJson["id"]),
      title: parsedJson["nome"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value.toString();
    return data;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["value"] = value;
    map["title"] = title;
    return map;
  }

  static List<ValueLabel> fromJsonListIdStr(List list) {
    return list.map((item) => ValueLabel.fromJsonIdStr(item)).toList();
  }

  static List<ValueLabel> fromJsonListIdInt(List list) {
    return list.map((item) => ValueLabel.fromJsonIdInt(item)).toList();
  }

  @override
  String toString() => "$title";

  @override
  operator ==(o) => o is ValueLabel && o.value == value;

  @override
  int get hashCode => value.hashCode ^ title.hashCode;
}

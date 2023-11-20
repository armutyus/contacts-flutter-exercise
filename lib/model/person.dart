class Person {
  String personId;
  String personName;
  String personPhone;

  Person(
      {required this.personId,
      required this.personName,
      required this.personPhone});

  factory Person.fromJson(String key, Map<dynamic, dynamic> json) {
    return Person(
        personId: key,
        personName: json["kisi_ad"] as String,
        personPhone: json["kisi_tel"] as String);
  }
}

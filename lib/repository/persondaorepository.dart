import 'package:firebase_database/firebase_database.dart';

class PersonDaoRepository {
  var refFirebasePerson = FirebaseDatabase.instance.ref("kisiler");

  Future<void> saveContact(String name, String phone) async {
    var personInfo = <String, dynamic>{};
    personInfo["kisi_id"] = "";
    personInfo["kisi_ad"] = name;
    personInfo["kisi_tel"] = phone;
    refFirebasePerson.push().set(personInfo);
  }

  Future<void> updateContact(String personId, String name, String phone) async {
    var personInfo = <String, dynamic>{};
    personInfo["kisi_ad"] = name;
    personInfo["kisi_tel"] = phone;
    refFirebasePerson.child(personId).update(personInfo);
  }

  Future<void> deleteContact(String personId) async {
    refFirebasePerson.child(personId).remove();
  }
}

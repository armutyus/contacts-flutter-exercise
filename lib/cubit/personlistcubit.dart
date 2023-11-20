import 'package:contacts_flutter_exercise/repository/persondaorepository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/person.dart';

class PersonListCubit extends Cubit<List<Person>> {
  PersonListCubit() : super(<Person>[]);

  var personDaoRepository = PersonDaoRepository();
  var refFirebasePerson = FirebaseDatabase.instance.ref("kisiler");

  Future<void> getAllPerson() async {
    refFirebasePerson.onValue.listen((event) {
      var response = event.snapshot.value as dynamic;
      if (response != null) {
        var personList = <Person>[];
        response.forEach((key, remotePerson) {
          var person = Person.fromJson(key, remotePerson);
          personList.add(person);
        });
        emit(personList);
      }
    });
  }

  Future<void> searchPerson(String input) async {
    refFirebasePerson.onValue.listen((event) {
      var response = event.snapshot.value as dynamic;
      if (response != null) {
        var personList = <Person>[];
        response.forEach((key, remotePerson) {
          var person = Person.fromJson(key, remotePerson);
          if (person.personName.contains(input)) {
            personList.add(person);
          }
        });
        emit(personList);
      }
    });
  }

  Future<void> deletePerson(String personId) async {
    await personDaoRepository.deleteContact(personId);
    await getAllPerson();
  }
}

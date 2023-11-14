import 'package:contacts_flutter_exercise/model/person.dart';
import 'package:flutter/material.dart';

class PersonDetail extends StatefulWidget {
  Person person;
  PersonDetail({super.key, required this.person});

  @override
  State<PersonDetail> createState() => _PersonDetailState();
}

class _PersonDetailState extends State<PersonDetail> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  Future<void> updateContact(int personId, String name, String phone) async {
    print("Person updated: $personId - $name - $phone");
  }

  @override
  void initState() {
    super.initState();

    var currentPerson = widget.person;
    nameController.text = currentPerson.personName;
    phoneController.text = currentPerson.personPhone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(hintText: "Phone Number"),
              ),
              ElevatedButton(
                  onPressed: (){
                    updateContact(widget.person.personId, nameController.text, phoneController.text);
                  },
                  child: const Text("UPDATE")
              )
            ],
          ),
        ),
      ),
    );
  }
}
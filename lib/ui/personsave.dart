import 'package:flutter/material.dart';

class PersonSave extends StatefulWidget {
  const PersonSave({super.key});

  @override
  State<PersonSave> createState() => _PersonSaveState();
}

class _PersonSaveState extends State<PersonSave> {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  Future<void> saveContact(String name, String phone) async {
    print("Person saved: $name - $phone");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Save")),
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
                    saveContact(nameController.text, phoneController.text);
                  },
                  child: const Text("SAVE")
              )
            ],
          ),
        ),
      ),
    );
  }
}
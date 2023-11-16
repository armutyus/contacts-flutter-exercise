import 'package:contacts_flutter_exercise/ui/persondetail.dart';
import 'package:contacts_flutter_exercise/ui/personsave.dart';
import 'package:flutter/material.dart';

import '../model/person.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isSearchActive = false;
  var searchBarFocusNode = FocusNode();

  Future<List<Person>> getAllPerson() async {
    var contactList = <Person>[];
    var p1 = Person(1, "John", "0007");
    var p2 = Person(2, "Wick", "0017");
    var p3 = Person(3, "Karl", "0027");
    contactList.addAll([p1, p2, p3]);
    return contactList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: isSearchActive ?
              SearchBar(
                focusNode: searchBarFocusNode,
                leading: const Icon(Icons.search),
                hintText: "Search someone",
                onChanged: (searchText){
                  print("Searching: $searchText");
                },
              )
              : const Text("Contacts"),
          actions: [
            IconButton(
                isSelected: isSearchActive,
                onPressed: (){
                  setState(() {
                    searchBarFocusNode.requestFocus();
                    isSearchActive = !isSearchActive;
                  });
                },
                icon: const Icon(Icons.search),
                selectedIcon: const Icon(Icons.cancel_outlined),
            ),
          ],
      ),
      body: FutureBuilder<List<Person>>(
        future: getAllPerson(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            var personList = snapshot.data;
            return ListView.builder(
                itemCount: personList!.length,
                itemBuilder: (context, index){
                  var person = personList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PersonDetail(person: person)
                          )
                      ).then((value) {
                        print("Returned to home");
                      });
                    },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${person.personName} - ${person.personPhone}"),
                              IconButton(
                                  onPressed: (){
                                    final snackBar = SnackBar(
                                      content: Text('Are you sure to delete ${person.personName}'),
                                      action: SnackBarAction(
                                        label: 'DELETE',
                                        onPressed: () {
                                          print("Deleted person id ${person.personId}");
                                        },
                                      ),
                                    );
                                    
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  },
                                  icon: const Icon(Icons.delete)
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonSave()))
              .then((value) => { print("Returned to home") });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

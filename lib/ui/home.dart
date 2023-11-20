import 'package:contacts_flutter_exercise/cubit/personlistcubit.dart';
import 'package:contacts_flutter_exercise/ui/persondetail.dart';
import 'package:contacts_flutter_exercise/ui/personsave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/person.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearchActive = false;
  var searchBarFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<PersonListCubit>().getAllPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchActive
            ? SearchBar(
                focusNode: searchBarFocusNode,
                leading: const Icon(Icons.search),
                hintText: "Search someone",
                onChanged: (searchText) {
                  if (searchText.isNotEmpty) {
                    context.read<PersonListCubit>().searchPerson(searchText);
                  } else {
                    context.read<PersonListCubit>().getAllPerson();
                  }
                },
              )
            : const Text("Contacts"),
        actions: [
          IconButton(
            isSelected: isSearchActive,
            onPressed: () {
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
      body: BlocBuilder<PersonListCubit, List<Person>>(
        builder: (context, personList) {
          if (personList.isNotEmpty) {
            return ListView.builder(
              itemCount: personList.length,
              itemBuilder: (context, index) {
                var person = personList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PersonDetail(person: person))).then((value) {
                        print("Returned to home");
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${person.personName} - ${person.personPhone}"),
                            IconButton(
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Are you sure to delete ${person.personName}'),
                                    action: SnackBarAction(
                                      label: 'DELETE',
                                      onPressed: () {
                                        context
                                            .read<PersonListCubit>()
                                            .deletePerson(person.personId);
                                      },
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                icon: const Icon(Icons.delete)),
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
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PersonSave()))
              .then((value) => {print("Returned to home")});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

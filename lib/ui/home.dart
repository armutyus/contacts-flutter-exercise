import 'package:contacts_flutter_exercise/ui/personsave.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isSearchActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Contacts"),
          actions: [
            isSearchActive ?
            IconButton(
                onPressed: (){
                  setState(() {
                    isSearchActive = false;
                  });
                },
                icon: const Icon(Icons.cancel_outlined)
            ) :
            IconButton(
                onPressed: (){
                  setState(() {
                    isSearchActive = true;
                  });
                },
                icon: const Icon(Icons.search)
            )
          ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

          ],
        ),
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

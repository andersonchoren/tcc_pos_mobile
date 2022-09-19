import 'package:agenda_de_estudos/model/disciplines.dart';
import 'package:agenda_de_estudos/screens/add_content/add_content.dart';
import 'package:agenda_de_estudos/screens/home/components/list_item.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus estudos"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListItem(
              discipline: disciplines[index],
            );
          },
          itemCount: disciplines.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) {
                return const AddContent();
              }),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

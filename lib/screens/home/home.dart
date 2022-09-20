import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/discipline_repository.dart';
import 'package:agenda_de_estudos/screens/add_content/add_content.dart';
import 'package:agenda_de_estudos/screens/add_discipline/add_discipline.dart';
import 'package:agenda_de_estudos/screens/home/components/list_item.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus estudos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return const AddDiscipline();
                  }),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: DisciplineRepository.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            var disciplines =
                snapshot.data!.map((item) => Discipline.fromMap(item)).toList();
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListItem(
                  discipline: disciplines[index],
                );
              },
              itemCount: disciplines.length,
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: Text("Não existem disciplinas cadastradas"),
              ),
            );
          }
        },
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

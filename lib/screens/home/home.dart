import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/discipline_repository.dart';
import 'package:agenda_de_estudos/screens/add_discipline/add_discipline.dart';
import 'package:agenda_de_estudos/screens/colors.dart';
import 'package:agenda_de_estudos/screens/home/components/list_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  List<Discipline> disciplines;
  Home({
    super.key,
    required this.disciplines,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        var result = await DisciplineRepository.findAll();
        widget.disciplines = result
            .map(
              (e) => Discipline.fromMap(e),
            )
            .toList();
        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Meus estudos"),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListItem(
              discipline: widget.disciplines[index],
            );
          },
          itemCount: widget.disciplines.length,
        ),
        floatingActionButton: FloatingActionButton(
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
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

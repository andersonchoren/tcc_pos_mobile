import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/content_repository.dart';
import 'package:agenda_de_estudos/screens/add_content/add_content.dart';
import 'package:agenda_de_estudos/screens/content_details/components/list_item.dart';
import 'package:flutter/material.dart';

class ContentDetails extends StatelessWidget {
  Discipline discipline;
  ContentDetails({
    super.key,
    required this.discipline,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus estudos de ${discipline.name}"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: ContentRepository.findContent(discipline),
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
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListItem(
                    icon: discipline.icon,
                    content: Content.fromMap(snapshot.data!.elementAt(index)),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: Text(
                      "Não existem conteúdos cadastrados nessa disciplina"),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) {
                return AddContent(
                  discipline: discipline.name,
                );
              }),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

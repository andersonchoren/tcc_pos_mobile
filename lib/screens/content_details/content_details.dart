import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/repository/content_repository.dart';
import 'package:agenda_de_estudos/screens/add_content/add_content.dart';
import 'package:agenda_de_estudos/screens/content_details/components/list_item.dart';
import 'package:flutter/material.dart';

class ContentDetails extends StatelessWidget {
  String disciplineName;
  String disciplineIcon;
  ContentDetails({
    super.key,
    required this.disciplineName,
    required this.disciplineIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus estudos de $disciplineName"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: ContentRepository.findContent(disciplineName),
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
                    icon: disciplineIcon,
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
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: ((context) {
              return AddContent(
                discipline: disciplineName,
              );
            }),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/content_repository.dart';
import 'package:agenda_de_estudos/screens/add_content/add_content.dart';
import 'package:agenda_de_estudos/screens/colors.dart';
import 'package:agenda_de_estudos/screens/content_details/components/details_list_item.dart';
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
        title: Text("Meus estudos em ${discipline.name}"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: ContentRepository.findContent(discipline.name),
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
                  return DetailsListItem(
                    discipline: discipline,
                    content: Content.fromMap(snapshot.data!.elementAt(index)),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.info,
                      color: secondary,
                      size: 100,
                    ),
                    Text(
                      "Você ainda não possui nenhum conteúdo para essa disciplina!",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: secondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
                discipline: discipline.name,
              );
            }),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

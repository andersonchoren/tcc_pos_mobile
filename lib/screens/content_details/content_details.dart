import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/content_repository.dart';
import 'package:agenda_de_estudos/screens/add_content/add_content.dart';
import 'package:agenda_de_estudos/screens/colors.dart';
import 'package:agenda_de_estudos/screens/content_details/components/details_list_item.dart';
import 'package:flutter/material.dart';

class ContentDetails extends StatefulWidget {
  Discipline discipline;
  ContentDetails({
    super.key,
    required this.discipline,
  });

  @override
  State<ContentDetails> createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus estudos em ${widget.discipline.name}"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: ContentRepository.findContent(widget.discipline.name),
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
              var contents = snapshot.data!;
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return DetailsListItem(
                      discipline: widget.discipline,
                      content: Content.fromMap(
                        contents.elementAt(index),
                      ),
                    );
                  },
                  itemCount: contents.length,
                ),
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
                discipline: widget.discipline.name,
              );
            }),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

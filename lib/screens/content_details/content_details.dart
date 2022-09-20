import 'package:agenda_de_estudos/model/content.dart';
import 'package:agenda_de_estudos/screens/content_details/components/list_item.dart';
import 'package:flutter/material.dart';

class ContentDetails extends StatelessWidget {
  List<Content>? contents;
  String icon;
  ContentDetails({
    super.key,
    required this.icon,
    this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus estudos de química"),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: (contents != null)
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return ListItem(
                    icon: icon,
                    content: contents![index],
                  );
                },
                itemCount: contents?.length,
              )
            : const Center(
                child: Text("Não existem conteúdos"),
              ),
      ),
    );
  }
}

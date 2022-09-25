import 'package:agenda_de_estudos/model/discipline.dart';
import 'package:agenda_de_estudos/repository/discipline_repository.dart';
import 'package:agenda_de_estudos/screens/colors.dart';
import 'package:agenda_de_estudos/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var disciplines = await DisciplineRepository.findAll();
  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en_US',
    supportedLocales: ['en_US', 'pt', 'es'],
  );
  runApp(
    LocalizedApp(
      delegate,
      App(disciplines: disciplines),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.disciplines,
  }) : super(key: key);

  final List<Map<String, dynamic>> disciplines;

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "OrganoEstudos",
        home: Home(
          disciplines: disciplines
              .map(
                (e) => Discipline.fromMap(e),
              )
              .toList(),
        ),
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: primary,
            secondary: secondary,
            onSecondary: Colors.white,
          ),
          toggleableActiveColor: secondary,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
      ),
    );
  }
}

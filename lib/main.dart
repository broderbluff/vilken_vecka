import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isoweek/isoweek.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vilken vecka',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('sv', ''), // Swedish, no country code
      ],
      locale: const Locale('sv'),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Week currentWeek = Week.current();

  List<Widget> daysWidgets(List<DateTime> days) {
    String locale = Localizations.localeOf(context).languageCode;
    final dateFormat = DateFormat('EEE', locale);

    List<Widget> widgets = [];
    days.forEach((element) {
      String readableDay = dateFormat.format(
        element,
      );
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            '${element.day}/${element.month}',
            textScaleFactor: 1.5,
            style: GoogleFonts.firaSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: readableDay == 'sön' ? Colors.red : Colors.black)),
          ),
          Text(
            readableDay,
            style: TextStyle(
                color: readableDay == 'sön' ? Colors.red : Colors.black),
          )
        ]),
      ));
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    String result = currentWeek.weekNumber.toString();
    print(currentWeek.days);

    List<DateTime> days = currentWeek.days;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Det är nu vecka:',
              textScaleFactor: 2,
              style: GoogleFonts.firaSansCondensed(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                height: 500,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    result,
                    style: GoogleFonts.anton(),
                    textScaleFactor: 100,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [...daysWidgets(days)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medication_app/provider/medication_provider.dart';
import 'package:medication_app/screens/AuthScreen.dart';
import 'package:medication_app/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MedicationList.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MedicationList(),
        ),
      ],
      child: MaterialApp(
        title: 'Medication App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xff4B57A3),
            secondary: const Color(0xff4B57A3),
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Color(0xff4B57A3),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const AuthScreen(),
      ),
    );
  }
}

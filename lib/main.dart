import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:new_project/screens/email_verification.dart';
import 'package:new_project/screens/home_screens/front_page.dart';
import 'package:new_project/screens/home_screens/widgets/routes.dart';
import 'package:new_project/screens/login_page.dart';
import 'package:new_project/screens/sign_up.dart';
import 'package:new_project/screens/spash_screen.dart';
import 'package:new_project/services/crud/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.initFlutter();

  if (!Hive.isAdapterRegistered(NotesModelAdapter().typeId)) {
    Hive.registerAdapter(NotesModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Notes',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: splashRoute,
      routes: {
        splashRoute: (context) => const LoadingPage(),
        loginRoute: (context) => const LoginPage(),
        signupRoute: (context) => const SignUp(),
        notesviewRoute: (context) => MainNotes(),
        emailverificationroute: (context) => const EmailVerification()
      },
    );
  }
}

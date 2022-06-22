import 'package:eazyydoctor/Emergency/EmergencyTap.dart';
import 'package:eazyydoctor/Emergency/data.dart';
import 'package:eazyydoctor/Emergency/id_screen.dart';
import 'package:eazyydoctor/Emergency/national.dart';
import 'package:eazyydoctor/Setting/Profile.dart';
import 'package:eazyydoctor/startscreen.dart';
import 'package:eazyydoctor/auth/signIn.dart';
import 'package:eazyydoctor/auth/signUp.dart';
import 'package:eazyydoctor/homeScreen.dart';
import 'package:eazyydoctor/src/global_bloc.dart';
import 'package:eazyydoctor/src/ui/homepage/homepage.dart';
import 'package:eazyydoctor/themeData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Emergency/file.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:eazyydoctor/screens/specialist_screen.dart';
import 'package:provider/provider.dart';
import 'notifier/doctors_notifier.dart';
import 'notifier/specialist_notifier.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SpecialistNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => DoctorsNotifier(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late GlobalBloc globalBloc;
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
        value: globalBloc,
        child: MaterialApp(
          title: 'Eazy Doctor',
          theme: ThemeData(
            textTheme:
            GoogleFonts.almaraiTextTheme(Theme.of(context).textTheme),
            primaryColor: MyThemeData.primaryColor,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(25),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          routes: {
            HomeScreen.routeName: (buildContext) => HomeScreen(),
            Profile.routeName: (buildContext) => Profile(),
            EmergencyTab.routeName: (buildContext) => EmergencyTab(),
            NatScreen.routeName: (buildContext) => NatScreen(),
            IdScreen.routeName: (buildContext) => IdScreen(),
            FileScreen.routeName: (buildContext) => FileScreen(),
            dataScreen.routeName: (buildContext) => dataScreen(),
            HomePage.routeName: (buildContext) => HomePage(),
            Login.routeName: (buildContext) => Login(),
            SignUp.routeName: (buildContext) => SignUp(),
            Startscreen.routeName: (buildContext) =>Startscreen(),

          },
          initialRoute: Startscreen.routeName,
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('ar', 'AE'),
            const Locale('en', 'US'),
          ],
          locale: Locale("ar", "AE"),
          debugShowCheckedModeBanner: false,
        ));
  }
}

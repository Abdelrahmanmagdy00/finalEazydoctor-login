import 'package:eazyydoctor/src/ui/homepage/homepage.dart';
import 'package:eazyydoctor/BMI/BmiTap.dart';
import 'package:eazyydoctor/Emergency/EmergencyTap.dart';
import 'package:eazyydoctor/News/NewsTap.dart';
import 'package:eazyydoctor/Setting/SettingTap.dart';

import 'package:eazyydoctor/themeData.dart';
import 'package:flutter/material.dart';
import 'package:eazyydoctor/screens/specialist_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eazyydoctor/constants.dart';
import 'package:workmanager/workmanager.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    Workmanager().registerPeriodicTask(
      "1",
      "periodic Notification",
      frequency: Duration(minutes: 5),
    );

    Workmanager().registerPeriodicTask(
      "2",
      "periodic Notification at day",
      frequency: Duration(days: 1),
    );
    super.initState();
  }
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(drawer: SettingTab(),extendBody: true,
          appBar: AppBar(

            backgroundColor: MyThemeData.primaryColor.withOpacity(0.5),
            centerTitle: true,
            title: Text(
              'Eazy Doctor',
              style: GoogleFonts.almarai(
                textStyle: textCard,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: MyThemeData.primaryColor.withOpacity(0.75),
            child: Icon(Icons.add_shopping_cart_rounded),
            onPressed: () {
              showSettingTap();
            },
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: MyThemeData.primaryColor.withOpacity(0.5)),
            child: BottomAppBar(
              elevation: 0,
              child: BottomNavigationBar(elevation: 0,backgroundColor: Colors.transparent,
                onTap: (index) {
                  currentPage = index;
                  setState(() {});
                },
                currentIndex: currentPage,
                selectedIconTheme:
                IconThemeData(color: MyThemeData.selectedColor),
                unselectedIconTheme:
                IconThemeData(color: MyThemeData.unselectedColor),
                items: [
                  BottomNavigationBarItem(
                      label: 'Home', icon: Icon(Icons.home_outlined)),
                  BottomNavigationBarItem(
                      label: 'BMI', icon: Icon(Icons.self_improvement_rounded)),
                  BottomNavigationBarItem(
                      label: 'Alarm', icon: Icon(Icons.alarm)),
                  BottomNavigationBarItem(
                      label: 'Emergency', icon: Icon(Icons.dangerous)),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              shape: CircularNotchedRectangle(),
              notchMargin: 2,
            ),
          ),
          body: getCurrentPage(),
        )
      ],
    );
  }

  Widget getCurrentPage() {
    if (currentPage == 0) {
      return NewsTap();
    } else if (currentPage == 1) {
      return BmiTap();
    } else if (currentPage == 2) {
      return HomePage();
    } else if (currentPage == 3) {
      return EmergencyTab();
    } else
      return SettingTab();
  }

  void showSettingTap() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return SpecialistScreen();
        });
  }
}
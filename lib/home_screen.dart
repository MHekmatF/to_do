

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/tabs/settings/settings_tab.dart';

import 'auth/login_screen.dart';
import 'auth/user_provider.dart';
import 'firebase_utils.dart';
import 'tabs/tasks/add_task_bottomsheet.dart';
import 'tabs/tasks/tasks_provider.dart';
import 'tabs/tasks/tasks_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [const TasksTap(),  SettingsTab()];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> appBarTitles = [
      AppLocalizations.of(context)!.todoList,
      AppLocalizations.of(context)!.settings,
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseUtils.logOut();
              Provider.of<UserProvider>(context,listen: false).currentUser = null;
              Provider.of<UserProvider>(context,listen: false).logout();
              Provider.of<TasksProvider>(context,listen: false).tasks = [];
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            icon: Icon(
              Icons.logout,
              size: 28.w,

            ),
          )
        ],
        title: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, top: 20),
            child: Text(appBarTitles[currentIndex])),
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        surfaceTintColor: Colors.white,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                label: 'Tasks',
                icon: ImageIcon(AssetImage("images/icon_list.png"))),
            BottomNavigationBarItem(
                label: 'Settings',
                icon: ImageIcon(AssetImage("images/icon_settings.png"))),
          ],
          onTap: (index) => setState(() {
            currentIndex = index;
          }),
          currentIndex: currentIndex,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            context: context,
            builder: (_) => const AddTaskBottomSheet(),
          );
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:study_box/feature/home/presentation/view/home_view.dart';
import 'package:study_box/feature/main_home/presentation/view/widget/custom_bottom_navigation_bar.dart';
import 'package:study_box/feature/profile/presentation/view/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  List<Widget> getScreens = [
    const HomeView(),
    const Center(child: Text('NotesView')),
    const Center(child: Text('ReminderView')),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: getScreens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

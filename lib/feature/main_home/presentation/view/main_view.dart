import 'package:flutter/material.dart';
import 'package:study_box/feature/home/presentation/view/home_view.dart';
import 'package:study_box/feature/main_home/presentation/view/widget/custom_bottom_navigation_bar.dart';
import 'package:study_box/feature/profile/presentation/view/profile_view.dart';
import 'package:study_box/feature/subject/presentation/view/subject_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> get getScreens => [
        HomeView(onNavigateToSubjects: () => changeIndex(1)),
        const SubjectView(),
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
        onTap: changeIndex,
      ),
    );
  }
}

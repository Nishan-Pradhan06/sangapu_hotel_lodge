import 'package:flutter/material.dart';
import '../../core/widgets/double_press_to_exit.dart';
import '../reports/pages/report_overview_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});
  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ReportOverviewPage(),
    Text('Home'),
    Text('Home'),
    Text('Home'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExit(
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _screens),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: Material(
          elevation: 8,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                label: 'Today',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded),
                label: 'Monthly',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_rounded),
                label: 'Reports',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

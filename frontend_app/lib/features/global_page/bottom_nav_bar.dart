import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/widgets/double_press_to_exit.dart';
import '../expenses/blocs/get_expenses/get_expenses_bloc.dart';
import '../expenses/page/expenses_page.dart';
import '../dashboard/page/dashboard.dart';
import '../income/pages/income_page.dart';
import '../statements/bloc/statements_bloc.dart';
import '../statements/pages/statements_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({super.key});
  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardPage(),
    IncomePage(),
    ExpensesPage(),
    StatementPage(),
  ];

  @override
  void initState() {
    context.read<StatementsBloc>().add(const StatementsEvent.getStatement());
    context.read<GetExpensesBloc>().add(const GetExpensesEvent.getExpenses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExit(
      child: Scaffold(
        backgroundColor: ColorScheme.of(context).surface,

        body: IndexedStack(index: _currentIndex, children: _screens),

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
                icon: Icon(Icons.trending_up_rounded),
                label: 'Income',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trending_down_rounded),
                label: 'Expenses',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_rounded),
                label: 'Statements',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/scores_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/standings_screen.dart';
import 'screens/teams_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IskoArena',
      theme: ThemeData(
        primaryColor: const Color(0xFF7B1113), // UP Maroon
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B1113),
          primary: const Color(0xFF7B1113),
          secondary: const Color(0xFFFFFFFF), // White
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7B1113),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF7B1113),
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    ScoresScreen(),
    ScheduleScreen(),
    StandingsScreen(),
    TeamsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IskoArena'),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball),
            label: 'Scores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Standings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Teams',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

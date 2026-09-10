import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/workers/presentation/workers_screen.dart';
import 'features/saree_types/presentation/saree_types_screen.dart';
import 'features/production/presentation/production_screen.dart';
import 'features/salary/presentation/salary_screen.dart';
import 'features/reports/presentation/reports_screen.dart';
import 'features/settings/presentation/settings_screen.dart';

class SareeManagementApp extends StatefulWidget {
  const SareeManagementApp({super.key});
  @override State<SareeManagementApp> createState() => _SareeManagementAppState();
}

class _SareeManagementAppState extends State<SareeManagementApp> {
  ThemeMode mode = ThemeMode.light;

  void toggleTheme() => setState(() {
    mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  });

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        ShellRoute(
          builder: (context, state, child) => AppShell(
            location: state.uri.path,
            child: child,
          ),
          routes: [
            GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
            GoRoute(path: '/workers', builder: (_, __) => const WorkersScreen()),
            GoRoute(path: '/saree-types', builder: (_, __) => const SareeTypesScreen()),
            GoRoute(path: '/production', builder: (_, __) => const ProductionScreen()),
            GoRoute(path: '/salary', builder: (_, __) => const SalaryScreen()),
            GoRoute(path: '/reports', builder: (_, __) => const ReportsScreen()),
            GoRoute(path: '/settings', builder: (_, __) => SettingsScreen(onToggleTheme: toggleTheme)),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Saree Management System',
      debugShowCheckedModeBanner: false,
      themeMode: mode,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple, brightness: Brightness.dark),
      routerConfig: router,
    );
  }
}

class AppShell extends StatelessWidget {
  final Widget child;
  final String location;
  const AppShell({super.key, required this.child, required this.location});

  int get index {
    const paths = ['/dashboard','/workers','/saree-types','/production','/salary','/reports','/settings'];
    final i = paths.indexOf(location);
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    const items = [
      NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Workers'),
      NavigationDestination(icon: Icon(Icons.checkroom_outlined), selectedIcon: Icon(Icons.checkroom), label: 'Sarees'),
      NavigationDestination(icon: Icon(Icons.factory_outlined), selectedIcon: Icon(Icons.factory), label: 'Production'),
      NavigationDestination(icon: Icon(Icons.payments_outlined), selectedIcon: Icon(Icons.payments), label: 'Salary'),
      NavigationDestination(icon: Icon(Icons.assessment_outlined), selectedIcon: Icon(Icons.assessment), label: 'Reports'),
      NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Saree Management System')),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        destinations: items,
        onDestinationSelected: (i) => context.go(const ['/dashboard','/workers','/saree-types','/production','/salary','/reports','/settings'][i]),
      ),
    );
  }
}

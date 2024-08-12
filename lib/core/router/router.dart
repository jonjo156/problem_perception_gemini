import 'package:go_router/go_router.dart';
import '../../features/results/presentation/results_page.dart';
import '../widgets/app_navigation_rail.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AppNavigationRail(),
    ),
    GoRoute(
      path: '/results',
      builder: (context, state) => const ResultsPage(),
    )
  ],
);

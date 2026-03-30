import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workouts_screen.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workout_sections_screen.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workout0/workout0_orchestrator.dart';
import 'package:lmm_app/features/auth/presentation/screens/onboarding_flow.dart';
import 'package:lmm_app/features/drift/presentation/screens/drift_screen.dart';
import 'package:lmm_app/features/now/presentation/screens/rtn_orchestrator.dart';
import 'package:lmm_app/core/router/scaffold_with_navbar.dart';
import 'package:lmm_app/features/tools_hub/presentation/screens/tools_hub_screen.dart';
import 'package:lmm_app/features/ai_coach/presentation/screens/ai_coach_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _shellNavigatorWorkoutsKey = GlobalKey<NavigatorState>(debugLabel: 'workouts');
final GlobalKey<NavigatorState> _shellNavigatorDriftKey = GlobalKey<NavigatorState>(debugLabel: 'drift');
final GlobalKey<NavigatorState> _shellNavigatorNowKey = GlobalKey<NavigatorState>(debugLabel: 'now');
final GlobalKey<NavigatorState> _shellNavigatorAICoachKey = GlobalKey<NavigatorState>(debugLabel: 'ai-coach');
final GlobalKey<NavigatorState> _shellNavigatorHubKey = GlobalKey<NavigatorState>(debugLabel: 'hub');

// Placeholder screen builders
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({required this.title, super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text(title)));
}

final appRouter = GoRouter(
  initialLocation: '/onboarding',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavbar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorWorkoutsKey,
          routes: [
            GoRoute(
              path: '/workouts',
              builder: (context, state) => const WorkoutsScreen(),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return WorkoutSectionsScreen(workoutId: id);
                  },
                  routes: [
                    GoRoute(
                      path: 'play',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final section = state.uri.queryParameters['section'];
                        return Workout0Orchestrator(initialSection: section);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDriftKey,
          routes: [
            GoRoute(
              path: '/drift',
              builder: (context, state) => const DriftScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorNowKey,
          routes: [
            GoRoute(
              path: '/now',
              builder: (context, state) {
                final fromWorkout = state.uri.queryParameters['from'] == 'workout';
                return RTNOrchestrator(accessedFromWorkout: fromWorkout);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAICoachKey,
          routes: [
            GoRoute(
              path: '/ai-coach',
              builder: (context, state) => const AICoachScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHubKey,
          routes: [
            GoRoute(
              path: '/hub',
              builder: (context, state) => const ToolsHubScreen(),
              routes: [
                GoRoute(
                  path: 'profile',
                  builder: (context, state) => const PlaceholderScreen(title: 'Profile'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingFlow(),
    ),
  ],
);

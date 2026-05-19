import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lmm_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workouts_screen.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workout_sections_screen.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workout0/workout0_orchestrator.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workout1/workout1_orchestrator.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workout2/workout2_orchestrator.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workout3/workout3_orchestrator.dart';
import 'package:lmm_app/features/workouts/presentation/screens/workout4/workout4_orchestrator.dart';
import 'package:lmm_app/features/auth/presentation/screens/onboarding_flow.dart';
import 'package:lmm_app/features/drift/presentation/screens/drift_screen.dart';
import 'package:lmm_app/features/now/presentation/screens/rtn_orchestrator.dart';
import 'package:lmm_app/core/router/scaffold_with_navbar.dart';
import 'package:lmm_app/features/tools_hub/presentation/screens/tools_hub_screen.dart';
import 'package:lmm_app/features/ai_coach/presentation/screens/ai_coach_screen.dart';
import 'package:lmm_app/features/muscle_dashboard/presentation/screens/muscle_dashboard_main.dart';
import 'package:lmm_app/features/library/presentation/screens/library_screen.dart';
import 'package:lmm_app/features/library/presentation/screens/library_module_screen.dart';
import 'package:lmm_app/features/library/presentation/screens/library_module_entry_screen.dart';
import 'package:lmm_app/features/library/domain/models/library_content.dart';
import 'package:lmm_app/features/profile/presentation/screens/profile_screen.dart';

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
                        final id = state.pathParameters['id']!;
                        final section = state.uri.queryParameters['section'];
                        switch (id) {
                          case '4':
                            return Workout4Orchestrator(initialSection: section);
                          case '3':
                            return Workout3Orchestrator(initialSection: section);
                          case '2':
                            return Workout2Orchestrator(initialSection: section);
                          case '1':
                            return Workout1Orchestrator(initialSection: section);
                          case '0':
                          default:
                            return Workout0Orchestrator(initialSection: section);
                        }
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
                  builder: (context, state) => const ProfileScreen(),
                ),
                GoRoute(
                  path: 'muscle-dashboard',
                  builder: (context, state) => const MuscleDashboardMain(),
                ),
                GoRoute(
                  path: 'library',
                  builder: (context, state) => const LibraryScreen(),
                  routes: [
                    GoRoute(
                      path: 'workout0',
                      builder: (context, state) => const LibraryModuleEntryScreen(
                        workoutIndex: 0,
                        title: 'Workout 0: Attention Control',
                        muscle: 'Attention Control',
                        onStartPath: '/hub/library/workout0/cards',
                      ),
                      routes: [
                        GoRoute(
                          path: 'cards',
                          builder: (context, state) => LibraryModuleScreen(module: workout0LibraryModule),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'workout1',
                      builder: (context, state) => const LibraryModuleEntryScreen(
                        workoutIndex: 1,
                        title: 'Workout 1: Story Separation',
                        muscle: 'Story Separation',
                        onStartPath: '/hub/library/workout1/cards',
                      ),
                      routes: [
                        GoRoute(
                          path: 'cards',
                          builder: (context, state) => LibraryModuleScreen(module: workout1LibraryModule),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'workout2',
                      builder: (context, state) => const LibraryModuleEntryScreen(
                        workoutIndex: 2,
                        title: 'Workout 2: Alarm Loop',
                        muscle: 'Alarm Loop Recognition',
                        onStartPath: '/hub/library/workout2/cards',
                      ),
                      routes: [
                        GoRoute(
                          path: 'cards',
                          builder: (context, state) => LibraryModuleScreen(module: workout2LibraryModule),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'workout3',
                      builder: (context, state) => const LibraryModuleEntryScreen(
                        workoutIndex: 3,
                        title: 'Workout 3: Reset',
                        muscle: 'Sensation Separation',
                        onStartPath: '/hub/library/workout3/cards',
                      ),
                      routes: [
                        GoRoute(
                          path: 'cards',
                          builder: (context, state) => LibraryModuleScreen(module: workout3LibraryModule),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'workout4',
                      builder: (context, state) => const LibraryModuleEntryScreen(
                        workoutIndex: 4,
                        title: 'Workout 4: Thought & Attention',
                        muscle: 'Cognitive Distance',
                        onStartPath: '/hub/library/workout4/cards',
                      ),
                      routes: [
                        GoRoute(
                          path: 'cards',
                          builder: (context, state) => LibraryModuleScreen(module: workout4LibraryModule),
                        ),
                      ],
                    ),
                  ],
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

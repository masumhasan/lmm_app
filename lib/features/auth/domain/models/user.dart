class User {
  final String id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.mock() => User(
        id: '1',
        username: 'Alex',
        email: 'alex@example.com',
      );
}

class UserState {
  final List<dynamic> progress;
  final Map<String, int> stats;
  final int streakDays;

  UserState({
    this.progress = const [],
    this.stats = const {},
    this.streakDays = 2,
  });

  factory UserState.mock() => UserState(
        progress: [],
        stats: {'Focus': 85, 'Clarity': 70},
        streakDays: 3,
      );
}

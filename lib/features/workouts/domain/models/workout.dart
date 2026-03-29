enum WorkoutStatus { notStarted, inProgress, completed }

class Workout {
  final int id;
  final String title;
  final String description;
  final int difficulty;
  final WorkoutStatus status;
  final List<WorkoutSection> sections;

  Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    this.status = WorkoutStatus.notStarted,
    required this.sections,
  });

  static List<Workout> mockList = [
    Workout(
      id: 0,
      title: 'Attention Control',
      description: 'Strengthen your core focus muscle.',
      difficulty: 1,
      status: WorkoutStatus.inProgress,
      sections: [
        WorkoutSection(id: 'theory', title: 'THEORY', description: 'Learn the core concepts and mental models.', duration: '3 min'),
        WorkoutSection(id: 'drills', title: 'DRILLS', description: 'Interactive exercises to build the skill.', duration: '4 min'),
        WorkoutSection(
          id: 'skill_reps', 
          title: 'SKILL REPS', 
          description: 'Train specific attention movements.', 
          duration: '3 min',
          subSections: [
            WorkoutSection(id: 'sr1', title: 'BELIEF BIAS', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr2', title: 'ATTENTION PULL', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr3', title: 'STAY OR SHIFT', description: '2 min reps', duration: ''),
          ]
        ),
      ],
    ),
    Workout(
      id: 1,
      title: 'Story Separation',
      description: 'Separate evidence from the stories you tell yourself.',
      difficulty: 2,
      status: WorkoutStatus.notStarted,
      sections: [],
    ),
    Workout(
      id: 2,
      title: 'Alarm Loop',
      description: 'Spot the second alarm (the echo) in real time.',
      difficulty: 3,
      status: WorkoutStatus.notStarted,
      sections: [],
    ),
  ];
}

class WorkoutSection {
  final String id;
  final String title;
  final String description;
  final String duration;
  final bool isCompleted;
  final bool isLocked;
  final List<WorkoutSection>? subSections;

  WorkoutSection({
    required this.id,
    required this.title,
    required this.description,
    this.duration = '',
    this.isCompleted = false,
    this.isLocked = false,
    this.subSections,
  });
}

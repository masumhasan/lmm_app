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
        WorkoutSection(
            id: 'theory',
            title: 'THEORY',
            description: 'Learn the core concepts and mental models.',
            duration: '3 min',
            subSections: [
              WorkoutSection(
                  id: 'theory',
                  title: 'THE UNTRAINED MIND',
                  description: 'Core models',
                  duration: ''),
            ]),
        WorkoutSection(
            id: 'drills',
            title: 'DRILLS',
            description: 'Interactive exercises to build the skill.',
            duration: '4 min',
            subSections: [
              WorkoutSection(
                  id: 'drills_entry',
                  title: 'REFLEX TEST',
                  description: 'Attention Control',
                  duration: ''),
              WorkoutSection(
                  id: 'drill2_entry',
                  title: 'URGENCY BAIT',
                  description: 'Resist the pull',
                  duration: ''),
              WorkoutSection(
                  id: 'drill3_entry',
                  title: 'OPEN LOOP TEST',
                  description: 'Completion Tolerance',
                  duration: ''),
            ]),
        WorkoutSection(
            id: 'skill_reps',
            title: 'SKILL REPS',
            description: 'Train specific attention movements.',
            duration: '3 min',
            subSections: [
              WorkoutSection(id: 'sr1', title: 'BELIEF BIAS', description: '2 min reps', duration: ''),
              WorkoutSection(id: 'sr2', title: 'ATTENTION PULL', description: '2 min reps', duration: ''),
              WorkoutSection(id: 'sr3', title: 'STAY OR SHIFT', description: '2 min reps', duration: ''),
            ]),
      ],
    ),
    Workout(
      id: 1,
      title: 'Story Separation',
      description: 'Separate evidence from the stories you tell yourself.',
      difficulty: 2,
      status: WorkoutStatus.notStarted,
      sections: [
        WorkoutSection(
            id: 'theory',
            title: 'THEORY',
            description: 'How stories form and distort perception.',
            duration: '3 min',
            subSections: [
              WorkoutSection(id: 'theory', title: 'STORY FORMATION', description: 'Perception models', duration: ''),
            ]),
        WorkoutSection(
            id: 'drills',
            title: 'DRILLS',
            description: 'Practice separating facts from narrative.',
            duration: '4 min',
            subSections: [
              WorkoutSection(id: 'drills', title: 'FACT VS STORY', description: 'Interactive sorting', duration: ''),
            ]),
        WorkoutSection(
          id: 'skill_reps',
          title: 'SKILL REPS',
          description: 'Train story detection movements.',
          duration: '3 min',
          subSections: [
            WorkoutSection(id: 'sr1', title: 'ATTENTION LANE', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr2', title: 'CERTAINTY DIAL', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr3', title: 'CONCRETE SORT', description: '2 min reps', duration: ''),
          ],
        ),
      ],
    ),
    Workout(
      id: 2,
      title: 'Alarm Loop',
      description: 'Spot the second alarm (the echo) in real time.',
      difficulty: 3,
      status: WorkoutStatus.notStarted,
      sections: [
        WorkoutSection(
            id: 'theory',
            title: 'THEORY',
            description: 'Understand the echo alarm mechanism.',
            duration: '3 min',
            subSections: [
              WorkoutSection(id: 'theory', title: 'ECHO MECHANISM', description: 'Alarm models', duration: ''),
            ]),
        WorkoutSection(
            id: 'drills',
            title: 'DRILLS',
            description: 'Spot and interrupt repeated alarms.',
            duration: '5 min',
            subSections: [
              WorkoutSection(id: 'drills', title: 'LOOP INTERRUPT', description: 'Interactive drills', duration: ''),
            ]),
        WorkoutSection(
          id: 'skill_reps',
          title: 'SKILL REPS',
          description: 'Train alarm loop interruption.',
          duration: '4 min',
          subSections: [
            WorkoutSection(id: 'sr1', title: 'THE CHECKING TRAP', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr2', title: 'THE CONTROL REBOUND', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr3', title: 'THE ESCAPE REFLEX', description: '2 min reps', duration: ''),
          ],
        ),
      ],
    ),
    Workout(
      id: 3,
      title: 'Reclaiming Safety',
      description: 'Teaching the system when it is actually safe.',
      difficulty: 4,
      status: WorkoutStatus.notStarted,
      sections: [
        WorkoutSection(
            id: 'theory',
            title: 'THEORY',
            description: 'How safety signals are processed.',
            duration: '3 min',
            subSections: [
              WorkoutSection(id: 'theory', title: 'SAFETY SIGNALS', description: 'Concepts', duration: ''),
            ]),
        WorkoutSection(
            id: 'drills',
            title: 'DRILLS',
            description: 'Practice safety recalibration.',
            duration: '5 min',
            subSections: [
              WorkoutSection(id: 'drills', title: 'RECALIBRATION', description: 'Drills', duration: ''),
            ]),
        WorkoutSection(
          id: 'skill_reps',
          title: 'SKILL REPS',
          description: 'Train safety signal recognition.',
          duration: '4 min',
          subSections: [
            WorkoutSection(id: 'sr1', title: 'CREATE THE SIGNAL', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr2', title: 'DON’T CHECK', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr3', title: 'THE INTERPRETATION RACE', description: '2 min reps', duration: ''),
          ],
        ),
      ],
    ),
    Workout(
      id: 4,
      title: 'The Overthinking Mind',
      description: 'Internal noise & attention regulation.',
      difficulty: 5,
      status: WorkoutStatus.notStarted,
      sections: [
        WorkoutSection(
            id: 'theory',
            title: 'THEORY',
            description: 'Understanding the mechanics of internal noise.',
            duration: '4 min',
            subSections: [
              WorkoutSection(id: 'theory', title: 'NOISE MECHANICS', description: 'Internal dialogue', duration: ''),
            ]),
        WorkoutSection(
            id: 'drills',
            title: 'DRILLS',
            description: 'Training the attention control muscle.',
            duration: '6 min',
            subSections: [
              WorkoutSection(id: 'drills', title: 'ATTENTION DRILLS', description: 'Skill building', duration: ''),
            ]),
        WorkoutSection(
          id: 'skill_reps',
          title: 'SKILL REPS',
          description: 'Applying control to real-time noise.',
          duration: '5 min',
          subSections: [
            WorkoutSection(id: 'sr1', title: 'STATIC HOLD', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr2', title: 'MONITORING REFLEX', description: '2 min reps', duration: ''),
            WorkoutSection(id: 'sr3', title: 'PREDICTION GAP', description: '2 min reps', duration: ''),
          ],
        ),
      ],
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

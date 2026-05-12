class DriftCardModel {
  final String id;
  final String theme;
  final String screenName;
  final List<String> textSequence;
  final int runtimeSeconds;

  const DriftCardModel({
    required this.id,
    required this.theme,
    required this.screenName,
    required this.textSequence,
    required this.runtimeSeconds,
  });

  static const List<DriftCardModel> firstEightDriftCards = [
    DriftCardModel(
      id: 'D01',
      theme: 'Attention Pull',
      screenName: 'Drift01_Attention_Phone',
      textSequence: [
        'The screen lights up.',
        'You look.',
        'Attention moved first.',
      ],
      runtimeSeconds: 13,
    ),
    DriftCardModel(
      id: 'D02',
      theme: 'Attention Pull',
      screenName: 'Drift02_Attention_Reply',
      textSequence: [
        'Still no reply.',
        'Check again.',
        'The pull came first.',
      ],
      runtimeSeconds: 13,
    ),
    DriftCardModel(
      id: 'D03',
      theme: 'Story Formation',
      screenName: 'Drift03_Story_Greeting',
      textSequence: [
        'They didn’t say hi.',
        'Something’s wrong.',
        'The story landed instantly.',
      ],
      runtimeSeconds: 14,
    ),
    DriftCardModel(
      id: 'D04',
      theme: 'Story Formation',
      screenName: 'Drift04_Story_Text',
      textSequence: [
        '“ok.”',
        'That was enough.',
        'Now the meaning starts.',
      ],
      runtimeSeconds: 13,
    ),
    DriftCardModel(
      id: 'D05',
      theme: 'Overthinking',
      screenName: 'Drift05_Overthinking_Replay',
      textSequence: [
        'It ended hours ago.',
        'But it’s still here.',
        'Attention never left.',
      ],
      runtimeSeconds: 14,
    ),
    DriftCardModel(
      id: 'D06',
      theme: 'Overthinking',
      screenName: 'Drift06_Overthinking_Future',
      textSequence: [
        'It hasn’t happened.',
        'Attention is already there.',
        'That’s the noise.',
      ],
      runtimeSeconds: 14,
    ),
    DriftCardModel(
      id: 'D07',
      theme: 'Overthinking',
      screenName: 'Drift07_Overthinking_SolveNow',
      textSequence: [
        'Think about this.',
        'Solve it now.',
        'Don’t leave it.',
        'Nothing happened.',
      ],
      runtimeSeconds: 15,
    ),
    DriftCardModel(
      id: 'D08',
      theme: 'False Urgency',
      screenName: 'Drift08_Urgency_Hook',
      textSequence: [
        'This needs attention.',
        'That feeling is the hook.',
        'Not the proof.',
      ],
      runtimeSeconds: 13,
    ),
  ];
}

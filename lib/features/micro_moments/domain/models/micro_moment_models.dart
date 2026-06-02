class MicroMomentThemeData {
  final String id;
  final String title;
  final String subtitle;
  final List<MicroMomentData> moments;

  const MicroMomentThemeData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.moments,
  });
}

class MicroMomentData {
  final String id;
  final String title;
  final List<MicroMomentScreenData> screens;
  final String completionLine;

  const MicroMomentData({
    required this.id,
    required this.title,
    required this.screens,
    required this.completionLine,
  });
}

class MicroMomentScreenData {
  final List<String> lines;

  const MicroMomentScreenData({
    required this.lines,
  });
}

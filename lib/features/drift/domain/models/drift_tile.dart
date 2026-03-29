enum DriftTileType { text, image }

class DriftTile {
  final int id;
  final String content;
  final DriftTileType type;
  final String? imageUrl;

  DriftTile({
    required this.id,
    required this.content,
    required this.type,
    this.imageUrl,
  });

  static List<DriftTile> mockList = [
    DriftTile(
      id: 1,
      type: DriftTileType.text,
      content: "The mind is like a mirror; it reflects without judging.",
    ),
    DriftTile(
      id: 2,
      type: DriftTileType.image,
      content: "A calm lake reflecting the sky.",
      imageUrl: "https://picsum.photos/seed/lake/800/1000",
    ),
    DriftTile(
      id: 3,
      type: DriftTileType.text,
      content: "Thoughts are just clouds passing through the vast sky of awareness.",
    ),
    DriftTile(
      id: 4,
      type: DriftTileType.image,
      content: "A single leaf floating on water.",
      imageUrl: "https://picsum.photos/seed/leaf/800/1000",
    ),
    DriftTile(
      id: 5,
      type: DriftTileType.text,
      content: "Notice the space between your thoughts.",
    ),
    DriftTile(
      id: 6,
      type: DriftTileType.image,
      content: "Distant mountains in the mist.",
      imageUrl: "https://picsum.photos/seed/mountains/800/1000",
    ),
  ];
}

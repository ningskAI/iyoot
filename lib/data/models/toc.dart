class Toc {
  final String id;
  final String href;
  final String label;
  final int level;
  final int startPage;
  final double startPercentage;
  final List<Toc> subitems;

  Toc({
    required this.id,
    required this.href,
    required this.label,
    required this.subitems,
    required this.level,
    required this.startPage,
    required this.startPercentage,
  });

  get percentage => '${(startPercentage * 100).toStringAsFixed(2)}%';

  factory Toc.fromJson(Map<String, dynamic> json) {
    return Toc(
      id: json['id'].toString(),
      href: json['href'],
      label: json['label'],
      startPage: json['startPage'] ?? 0,
      startPercentage: (json['startPercentage'] ?? 0.0).toDouble(),
      level: json['level'] ?? 0,
      subitems: json['subitems'] == null
          ? []
          : (json['subitems'] as List).map((i) => Toc.fromJson(i)).toList(),
    );
  }
}

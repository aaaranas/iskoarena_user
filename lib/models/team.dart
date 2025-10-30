class Team {
  final String id;
  final String name;
  final String abbreviation;
  final String primaryColor;
  final String secondaryColor;
  final String logo;
  final List<String> playerIds;
  final Map<String, dynamic> stats;

  Team({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.primaryColor,
    required this.secondaryColor,
    required this.logo,
    required this.playerIds,
    required this.stats,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      abbreviation: json['abbreviation'],
      primaryColor: json['primaryColor'],
      secondaryColor: json['secondaryColor'],
      logo: json['logo'],
      playerIds: List<String>.from(json['playerIds']),
      stats: Map<String, dynamic>.from(json['stats']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'logo': logo,
      'playerIds': playerIds,
      'stats': stats,
    };
  }
}
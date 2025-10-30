class Player {
  final String id;
  final String name;
  final String imageUrl;
  final String position;
  final int jerseyNumber;
  final String team;
  final String sport;

  Player({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.position,
    required this.jerseyNumber,
    required this.team,
    required this.sport,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      position: json['position'],
      jerseyNumber: json['jerseyNumber'],
      team: json['team'],
      sport: json['sport'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'position': position,
      'jerseyNumber': jerseyNumber,
      'team': team,
      'sport': sport,
    };
  }
}
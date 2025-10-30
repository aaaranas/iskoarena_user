class Game {
  final String id;
  final String sport;
  final String homeTeamId;
  final String awayTeamId;
  final DateTime dateTime;
  final String venue;
  final Map<String, dynamic> score;
  final String status; // "scheduled", "live", "finished"
  final Map<String, dynamic> stats;

  Game({
    required this.id,
    required this.sport,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.dateTime,
    required this.venue,
    required this.score,
    required this.status,
    required this.stats,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      sport: json['sport'],
      homeTeamId: json['homeTeamId'],
      awayTeamId: json['awayTeamId'],
      dateTime: DateTime.parse(json['dateTime']),
      venue: json['venue'],
      score: Map<String, dynamic>.from(json['score']),
      status: json['status'],
      stats: Map<String, dynamic>.from(json['stats']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sport': sport,
      'homeTeamId': homeTeamId,
      'awayTeamId': awayTeamId,
      'dateTime': dateTime.toIso8601String(),
      'venue': venue,
      'score': score,
      'status': status,
      'stats': stats,
    };
  }
}
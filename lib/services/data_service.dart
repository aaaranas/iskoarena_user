import '../models/game.dart';
import '../models/player.dart';
import '../models/team.dart';
import '../models/constants.dart';

class DataService {
  // Singleton instance
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  // Sample data - In a real app, this would come from an API or database
  List<Game> getGames() {
    return [
      Game(
        id: '1',
        sport: 'Basketball',
        homeTeamId: 'COS',
        awayTeamId: 'CSS',
        dateTime: DateTime.now(),
        venue: 'UP Cebu Gym',
        score: {'home': 82, 'away': 78},
        status: 'live',
        stats: {
          'quarter': 4,
          'timeRemaining': '2:30',
        },
      ),
      Game(
        id: '2',
        sport: 'Basketball',
        homeTeamId: 'SOM',
        awayTeamId: 'CCAD',
        dateTime: DateTime.now().add(const Duration(hours: 2)),
        venue: 'UP Cebu Gym',
        score: {'home': 0, 'away': 0},
        status: 'scheduled',
        stats: {},
      ),
      Game(
        id: '3',
        sport: 'Volleyball',
        homeTeamId: 'CCAD',
        awayTeamId: 'COS',
        dateTime: DateTime.now(),
        venue: 'UP Cebu Court',
        score: {'home': 25, 'away': 23},
        status: 'live',
        stats: {
          'set': 3,
          'sets': {'home': 2, 'away': 0},
        },
      ),
      Game(
        id: '4',
        sport: 'Football',
        homeTeamId: 'CSS',
        awayTeamId: 'SOM',
        dateTime: DateTime.now().subtract(const Duration(hours: 1)),
        venue: 'UP Cebu Field',
        score: {'home': 2, 'away': 2},
        status: 'finished',
        stats: {
          'half': 'Full Time',
        },
      ),
      Game(
        id: '5',
        sport: 'Chess',
        homeTeamId: 'COS',
        awayTeamId: 'CCAD',
        dateTime: DateTime.now(),
        venue: 'UP Cebu Library',
        score: {'home': 3, 'away': 1},
        status: 'live',
        stats: {
          'boards': {'completed': 4, 'total': 6},
        },
      ),
    ];
  }

  List<Team> getTeams() {
    final teams = <Team>[];
    
    Constants.teams.forEach((key, value) {
      teams.add(
        Team(
          id: key,
          name: value['name']!,
          abbreviation: value['abbreviation']!,
          primaryColor: value['primaryColor']!,
          secondaryColor: value['secondaryColor']!,
          logo: 'assets/images/teams/$key.png', // You'll need to add these images
          playerIds: [],
          stats: {
            'wins': (key.hashCode % 3) + 1, // Random number of wins between 1-3
            'losses': (key.hashCode % 2) + 1, // Random number of losses between 1-2
            'rank': 1,
          },
        ),
      );
    });

    return teams;
  }

  List<Player> getPlayers(String teamId, String sport) {
    // Sample players with positions based on the sport
    final positions = {
      'Basketball': ['Guard', 'Forward', 'Center'],
      'Volleyball': ['Setter', 'Middle Blocker', 'Outside Hitter', 'Libero'],
      'Football': ['Goalkeeper', 'Defender', 'Midfielder', 'Forward'],
      'Softball': ['Pitcher', 'Catcher', 'Infielder', 'Outfielder'],
      'Chess': ['Board 1', 'Board 2', 'Board 3', 'Board 4'],
      'Badminton': ['Singles', 'Doubles'],
    };

    final sportPositions = positions[sport] ?? ['Player'];
    final players = <Player>[];
    
    // Generate 5-10 players per team for each sport
    for (var i = 0; i < 8; i++) {
      players.add(
        Player(
          id: '$teamId-$sport-$i',
          name: 'Player ${i + 1}',
          imageUrl: 'assets/images/players/placeholder.png',
          position: sportPositions[i % sportPositions.length],
          jerseyNumber: i + 1,
          team: teamId,
          sport: sport,
        ),
      );
    }

    return players;
  }

  List<String> getSports() {
    return Constants.sports;
  }
}
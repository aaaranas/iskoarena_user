import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/data_service.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final games = DataService().getGames();
    final sports = DataService().getSports();

    return DefaultTabController(
      length: sports.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: sports.map((sport) => Tab(text: sport)).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: sports.map((sport) {
                final sportGames = games.where((game) => game.sport == sport).toList();
                return _GamesList(games: sportGames);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _GamesList extends StatelessWidget {
  final List<Game> games;

  const _GamesList({required this.games});

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) {
      return const Center(
        child: Text('No games scheduled'),
      );
    }

    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      game.status.toUpperCase(),
                      style: TextStyle(
                        color: game.status == 'live'
                            ? Colors.red
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(game.venue),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(game.homeTeamId),
                    Text(game.score['home'].toString()),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(game.awayTeamId),
                    Text(game.score['away'].toString()),
                  ],
                ),
                if (game.status == 'live') ...[
                  const SizedBox(height: 8),
                  Text(
                    'Q${game.stats['quarter']} - ${game.stats['timeRemaining']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
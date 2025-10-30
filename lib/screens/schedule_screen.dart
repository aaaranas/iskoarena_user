import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/data_service.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              children: sports.map((sport) => _SportSchedule(sport: sport)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SportSchedule extends StatelessWidget {
  final String sport;

  const _SportSchedule({required this.sport});

  @override
  Widget build(BuildContext context) {
    final games = DataService().getGames()
      .where((game) => game.sport == sport)
      .toList();

    if (games.isEmpty) {
      return const Center(
        child: Text('No games scheduled'),
      );
    }

    // Group games by date
    final gamesByDate = <DateTime, List<Game>>{};
    for (final game in games) {
      final date = DateTime(
        game.dateTime.year,
        game.dateTime.month,
        game.dateTime.day,
      );
      gamesByDate.putIfAbsent(date, () => []).add(game);
    }

    final sortedDates = gamesByDate.keys.toList()..sort();

    return ListView.builder(
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final gamesOnDate = gamesByDate[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _formatDate(date),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...gamesOnDate.map((game) => _GameCard(game: game)),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    if (date == today) {
      return 'Today';
    } else if (date == tomorrow) {
      return 'Tomorrow';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }
}

class _GameCard extends StatelessWidget {
  final Game game;

  const _GameCard({required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${game.dateTime.hour}:${game.dateTime.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(game.venue),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Text(game.homeTeamId, textAlign: TextAlign.center)),
                const Text(' vs '),
                Expanded(child: Text(game.awayTeamId, textAlign: TextAlign.center)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
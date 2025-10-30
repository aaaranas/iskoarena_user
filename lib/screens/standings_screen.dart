import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../models/team.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

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
              children: sports.map((sport) => _StandingsTable(sport: sport)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _StandingsTable extends StatelessWidget {
  final String sport;

  const _StandingsTable({required this.sport});

  @override
  Widget build(BuildContext context) {
    final teams = DataService().getTeams();
    // Sort teams by win percentage
    teams.sort((a, b) {
      final aWins = a.stats['wins'] as int;
      final bWins = b.stats['wins'] as int;
      return bWins.compareTo(aWins);
    });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(40), // Rank
            1: FlexColumnWidth(3), // Team
            2: FixedColumnWidth(40), // W
            3: FixedColumnWidth(40), // L
            4: FlexColumnWidth(2), // PCT
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              children: [
                _buildHeaderCell('#'),
                _buildHeaderCell('TEAM'),
                _buildHeaderCell('W'),
                _buildHeaderCell('L'),
                _buildHeaderCell('PCT'),
              ],
            ),
            ...teams.asMap().entries.map((entry) {
              final index = entry.key;
              final team = entry.value;
              final wins = team.stats['wins'] as int;
              final losses = team.stats['losses'] as int;
              final pct = wins + losses > 0 ? wins / (wins + losses) : 0.0;

              return TableRow(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.white : Colors.grey[50],
                ),
                children: [
                  _buildCell((index + 1).toString()),
                  _buildCell(team.abbreviation),
                  _buildCell(wins.toString()),
                  _buildCell(losses.toString()),
                  _buildCell(pct.toStringAsFixed(3)),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
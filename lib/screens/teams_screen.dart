import 'package:flutter/material.dart';
import '../models/team.dart';
import '../models/player.dart';
import '../services/data_service.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teams = DataService().getTeams();
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
              children: sports.map((sport) => _TeamGrid(teams: teams, sport: sport)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamGrid extends StatelessWidget {
  final List<Team> teams;
  final String sport;

  const _TeamGrid({required this.teams, required this.sport});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: teams.map((team) => _TeamCard(team: team, sport: sport)).toList(),
    );
  }
}

class _TeamCard extends StatelessWidget {
  final Team team;
  final String sport;

  const _TeamCard({required this.team, required this.sport});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _TeamDetailScreen(team: team, sport: sport),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shield, size: 48), // Placeholder for team logo
            const SizedBox(height: 8),
            Text(
              team.abbreviation,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              team.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamDetailScreen extends StatelessWidget {
  final Team team;
  final String sport;

  const _TeamDetailScreen({required this.team, required this.sport});

  @override
  Widget build(BuildContext context) {
    final players = DataService().getPlayers(team.id, sport);

    return Scaffold(
      appBar: AppBar(
        title: Text(team.name),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(player.jerseyNumber.toString()),
            ),
            title: Text(player.name),
            subtitle: Text(player.position),
            trailing: Text('#${player.jerseyNumber}'),
          );
        },
      ),
    );
  }
}
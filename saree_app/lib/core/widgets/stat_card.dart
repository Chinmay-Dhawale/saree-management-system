import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  const StatCard({super.key, required this.title, required this.value, required this.icon});
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Row(children: [
        CircleAvatar(child: Icon(icon)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 5),
          Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        ]))
      ]),
    ),
  );
}

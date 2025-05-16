import 'package:flutter/material.dart';
import 'package:pricecalc/features/history/history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text("История")),
          SliverList.builder(
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: HistoryCard(),
                ),
          ),
        ],
      ),
    );
  }
}

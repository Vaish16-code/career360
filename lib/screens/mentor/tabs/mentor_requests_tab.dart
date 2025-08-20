import 'package:flutter/material.dart';
import '../../../theme.dart';

class MentorRequestsTab extends StatelessWidget {
  const MentorRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Requests'),
      ),
      body: const Center(child: Text('Mentor Requests Tab - Coming Soon')),
    );
  }
}

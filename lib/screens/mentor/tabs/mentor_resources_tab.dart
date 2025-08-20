import 'package:flutter/material.dart';
import '../../../theme.dart';

class MentorResourcesTab extends StatelessWidget {
  const MentorResourcesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Resources'),
      ),
      body: const Center(child: Text('Mentor Resources Tab - Coming Soon')),
    );
  }
}

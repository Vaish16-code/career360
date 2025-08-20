import 'package:flutter/material.dart';
import '../../../theme.dart';

class MentorMessagesTab extends StatelessWidget {
  const MentorMessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Messages'),
      ),
      body: const Center(child: Text('Mentor Messages Tab - Coming Soon')),
    );
  }
}

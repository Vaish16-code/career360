import 'package:flutter/material.dart';
import '../../../theme.dart';

class MentorSessionsTab extends StatelessWidget {
  const MentorSessionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sessions'),
        actions: [
          IconButton(
            onPressed: () {
              // Update availability
            },
            icon: Icon(Icons.calendar_today, color: kOnSurface),
          ),
        ],
      ),
      body: const Center(child: Text('Mentor Sessions Tab - Coming Soon')),
    );
  }
}

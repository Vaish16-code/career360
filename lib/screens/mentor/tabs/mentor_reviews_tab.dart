import 'package:flutter/material.dart';
import '../../../theme.dart';

class MentorReviewsTab extends StatelessWidget {
  const MentorReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Reviews'),
      ),
      body: const Center(child: Text('Mentor Reviews Tab - Coming Soon')),
    );
  }
}

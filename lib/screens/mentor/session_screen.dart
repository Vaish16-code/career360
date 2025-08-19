import 'package:flutter/material.dart';
import '../../theme.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Session Management',
          style: TextStyle(fontWeight: FontWeight.w800, color: kGradientStart),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          ElevatedButton.icon(
            onPressed: () => _updateAvailability(context),
            icon: const Icon(Icons.schedule, size: 16),
            label: const Text('Update Availability'),
            style: ElevatedButton.styleFrom(
              backgroundColor: kGradientStart,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: kGradientStart,
          unselectedLabelColor: Colors.grey,
          indicatorColor: kGradientStart,
          tabs: const [
            Tab(text: 'Upcoming Sessions'),
            Tab(text: 'Past Sessions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildUpcomingSessions(), _buildPastSessions()],
      ),
    );
  }

  Widget _buildUpcomingSessions() {
    final upcomingSessions = [
      {
        'student': 'Alex Chen',
        'date': 'Aug 20, 2025',
        'time': '2:00 PM - 3:00 PM',
        'link': 'https://meet.google.com/abc-defg-hij',
        'status': 'Confirmed',
      },
      {
        'student': 'Maria Garcia',
        'date': 'Aug 21, 2025',
        'time': '10:00 AM - 11:00 AM',
        'link': 'https://zoom.us/j/123456789',
        'status': 'Pending',
      },
      {
        'student': 'John Smith',
        'date': 'Aug 22, 2025',
        'time': '4:00 PM - 5:00 PM',
        'link': 'In-person at Tech Hub',
        'status': 'Confirmed',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: upcomingSessions.length,
      itemBuilder: (context, index) {
        final session = upcomingSessions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: kGradientStart,
              child: Text(
                session['student']![0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            title: Text(
              session['student']!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text('${session['date']} • ${session['time']}'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.link, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        session['link']!,
                        style: const TextStyle(
                          color: kGradientStart,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: session['status'] == 'Confirmed'
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                session['status']!,
                style: TextStyle(
                  color: session['status'] == 'Confirmed'
                      ? Colors.green
                      : Colors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPastSessions() {
    final List<Map<String, dynamic>> pastSessions = [
      {
        'student': 'Emma Wilson',
        'date': 'Aug 18, 2025',
        'time': '3:00 PM - 4:00 PM',
        'rating': 5,
        'feedback': 'Excellent guidance on career planning!',
      },
      {
        'student': 'David Kim',
        'date': 'Aug 17, 2025',
        'time': '1:00 PM - 2:00 PM',
        'rating': 4,
        'feedback': 'Very helpful session on technical skills.',
      },
      {
        'student': 'Sofia Rodriguez',
        'date': 'Aug 16, 2025',
        'time': '11:00 AM - 12:00 PM',
        'rating': 5,
        'feedback': 'Amazing insights into the industry!',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pastSessions.length,
      itemBuilder: (context, index) {
        final session = pastSessions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(
                (session['student'] as String)[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            title: Text(
              session['student'] as String,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text('${session['date']} • ${session['time']}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (starIndex) {
                    return Icon(
                      starIndex < (session['rating'] as int)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  session['feedback'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          ),
        );
      },
    );
  }

  void _updateAvailability(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Availability'),
        content: const Text('Availability management feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

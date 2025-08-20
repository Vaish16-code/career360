import 'package:flutter/material.dart';
import '../../../theme.dart';

class StudentHomeTab extends StatelessWidget {
  const StudentHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: kPrimaryContainer,
              child: Icon(Icons.person, color: kPrimary),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning,',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: kOnSurfaceVariant),
                ),
                Text(
                  'John Student',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: kOnSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Show notifications
            },
            icon: const Badge(
              label: Text('3'),
              child: Icon(Icons.notifications_outlined, color: kOnSurface),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kGradientStart, kGradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎯 Ready to learn?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: kOnPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Connect with expert mentors and accelerate your career growth',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: kOnPrimary.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to mentors tab
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOnPrimary,
                      foregroundColor: kPrimary,
                    ),
                    child: const Text('Find Mentors'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.school,
                    title: 'Sessions',
                    value: '12',
                    subtitle: 'Completed',
                    color: kSuccess,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.schedule,
                    title: 'Upcoming',
                    value: '3',
                    subtitle: 'This week',
                    color: kWarning,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.star,
                    title: 'Rating',
                    value: '4.8',
                    subtitle: 'Average',
                    color: kPrimary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Upcoming Sessions
            Text(
              'Upcoming Sessions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: kOnSurface,
              ),
            ),
            const SizedBox(height: 16),

            ..._buildUpcomingSessions(),

            const SizedBox(height: 24),

            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: kOnSurface,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.search,
                    title: 'Find Mentors',
                    subtitle: 'Browse expert mentors',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.calendar_today,
                    title: 'Schedule Session',
                    subtitle: 'Book a mentoring call',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return customCard(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kOnSurface,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: kOnSurfaceVariant,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: kOnSurfaceVariant),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildUpcomingSessions() {
    final sessions = [
      {
        'mentor': 'Dr. Sarah Wilson',
        'topic': 'Career Planning in Tech',
        'time': 'Today, 2:00 PM',
        'duration': '60 min',
        'type': 'Video Call',
      },
      {
        'mentor': 'Michael Chen',
        'topic': 'Frontend Development',
        'time': 'Tomorrow, 10:00 AM',
        'duration': '45 min',
        'type': 'Chat',
      },
    ];

    return sessions.map((session) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: customCard(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryContainer,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(Icons.person, color: kPrimary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session['mentor']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      session['topic']!,
                      style: const TextStyle(color: kOnSurfaceVariant, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 16,
                          color: kOnSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${session['time']} • ${session['duration']}',
                          style: const TextStyle(
                            color: kOnSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  session['type']!,
                  style: const TextStyle(
                    color: kPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return customCard(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kPrimaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: kPrimary, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: kOnSurfaceVariant, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

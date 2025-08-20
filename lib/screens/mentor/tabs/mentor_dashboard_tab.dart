import 'package:flutter/material.dart';
import '../../../theme.dart';

class MentorDashboardTab extends StatelessWidget {
  const MentorDashboardTab({super.key});

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
                  'Welcome back,',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: kOnSurfaceVariant),
                ),
                Text(
                  'Dr. Sarah Mentor',
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
              label: Text('2'),
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
            // Profile Overview Card
            customCard(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: kPrimaryContainer,
                        child: Icon(Icons.person, size: 40, color: kPrimary),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: kPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, size: 16, color: kOnPrimary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Sarah Mentor',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const Text(
                          'Software Engineering Expert',
                          style: TextStyle(
                            color: kPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.star, size: 16, color: kWarning),
                            SizedBox(width: 4),
                            Text(
                              '4.9 • 127 reviews',
                              style: TextStyle(
                                color: kOnSurfaceVariant,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // Edit profile
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.schedule,
                    title: 'Upcoming',
                    value: '5',
                    subtitle: 'Sessions',
                    color: kPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.request_page,
                    title: 'Pending',
                    value: '3',
                    subtitle: 'Requests',
                    color: kWarning,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.star,
                    title: 'Rating',
                    value: '4.9',
                    subtitle: 'Average',
                    color: kSuccess,
                  ),
                ),
              ],
            ),

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
                    icon: Icons.calendar_today,
                    title: 'Update Availability',
                    subtitle: 'Manage your schedule',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.upload_file,
                    title: 'Upload Resource',
                    subtitle: 'Share learning materials',
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Recent Activity
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: kOnSurface,
              ),
            ),
            const SizedBox(height: 16),

            ..._buildRecentActivity(),
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

  List<Widget> _buildRecentActivity() {
    final activities = [
      {
        'type': 'session',
        'title': 'Session completed with John Student',
        'subtitle': 'Software Architecture Discussion',
        'time': '2 hours ago',
        'icon': Icons.video_call,
      },
      {
        'type': 'request',
        'title': 'New mentorship request',
        'subtitle': 'From Sarah Johnson - UI/UX Design',
        'time': '4 hours ago',
        'icon': Icons.person_add,
      },
      {
        'type': 'review',
        'title': 'New review received',
        'subtitle': '5 stars from Michael Chen',
        'time': '1 day ago',
        'icon': Icons.star,
      },
    ];

    return activities.map((activity) {
      Color iconColor;
      Color backgroundColor;

      switch (activity['type']) {
        case 'session':
          iconColor = kSuccess;
          backgroundColor = kSuccess.withOpacity(0.1);
          break;
        case 'request':
          iconColor = kWarning;
          backgroundColor = kWarning.withOpacity(0.1);
          break;
        case 'review':
          iconColor = kPrimary;
          backgroundColor = kPrimary.withOpacity(0.1);
          break;
        default:
          iconColor = kOnSurfaceVariant;
          backgroundColor = kSurfaceVariant;
      }

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: customCard(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.zero,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  activity['icon'] as IconData,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      activity['subtitle'] as String,
                      style: const TextStyle(color: kOnSurfaceVariant, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                activity['time'] as String,
                style: const TextStyle(color: kOnSurfaceVariant, fontSize: 11),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

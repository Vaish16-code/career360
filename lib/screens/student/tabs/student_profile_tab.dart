import 'package:flutter/material.dart';
import '../../../theme.dart';
import '../../auth/login_screen.dart';

class StudentProfileTab extends StatelessWidget {
  const StudentProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              // Show settings
            },
            icon: const Icon(Icons.settings, color: kOnSurface),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            customCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: kPrimaryContainer,
                        child: Icon(Icons.person, size: 50, color: kPrimary),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: kPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Edit profile picture
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              color: kOnPrimary,
                              size: 16,
                            ),
                            iconSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'John Student',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Computer Science Student',
                    style: TextStyle(fontSize: 16, color: kOnSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'john.student@email.com',
                    style: TextStyle(fontSize: 14, color: kOnSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      // Edit profile
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.school,
                    title: 'Sessions',
                    value: '12',
                    subtitle: 'Completed',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.people,
                    title: 'Mentors',
                    value: '3',
                    subtitle: 'Connected',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.star,
                    title: 'Rating',
                    value: '4.8',
                    subtitle: 'Average',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Academic Info
            customCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Academic Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(Icons.school, 'Level', 'Undergraduate'),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.interests, 'Interest', 'Technology'),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.location_on, 'Location', 'New York, USA'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Learning Goals
            customCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Learning Goals',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        [
                          'Software Architecture',
                          'Design Patterns',
                          'System Design',
                          'Career Planning',
                        ].map((goal) {
                          return Chip(
                            label: Text(goal),
                            backgroundColor: kSecondaryContainer,
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Menu Options
            customCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildMenuOption(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    subtitle: 'Manage your notifications',
                    onTap: () {},
                  ),
                  _buildMenuOption(
                    icon: Icons.help,
                    title: 'Help & Support',
                    subtitle: 'Get help or contact support',
                    onTap: () {},
                  ),
                  _buildMenuOption(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    subtitle: 'Read our privacy policy',
                    onTap: () {},
                  ),
                  _buildMenuOption(
                    icon: Icons.info,
                    title: 'About',
                    subtitle: 'App version and information',
                    onTap: () {},
                  ),
                  _buildMenuOption(
                    icon: Icons.logout,
                    title: 'Logout',
                    subtitle: 'Sign out of your account',
                    isDestructive: true,
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
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
  }) {
    return customCard(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Icon(icon, color: kPrimary, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: kOnSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: kOnSurfaceVariant),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: kOnSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDestructive
                    ? kError.withOpacity(0.1)
                    : kPrimaryContainer.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isDestructive ? kError : kPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isDestructive ? kError : kOnSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: kOnSurfaceVariant),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: kOnSurfaceVariant),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            style: FilledButton.styleFrom(backgroundColor: kError),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

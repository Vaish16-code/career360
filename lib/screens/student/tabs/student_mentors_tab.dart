import 'package:flutter/material.dart';
import '../../../theme.dart';

class StudentMentorsTab extends StatefulWidget {
  const StudentMentorsTab({super.key});

  @override
  State<StudentMentorsTab> createState() => _StudentMentorsTabState();
}

class _StudentMentorsTabState extends State<StudentMentorsTab> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Technology',
    'Design',
    'Business',
    'Medicine',
    'Engineering',
    'Arts',
  ];

  final List<Map<String, dynamic>> _mentors = [
    {
      'name': 'Dr. Sarah Wilson',
      'expertise': 'Software Engineering',
      'category': 'Technology',
      'rating': 4.9,
      'reviews': 127,
      'experience': '8 years',
      'company': 'Google',
      'price': '\$50/hour',
      'languages': ['English', 'Spanish'],
      'availability': 'Available now',
      'image': 'assets/images/mentor1.jpg',
    },
    {
      'name': 'Michael Chen',
      'expertise': 'UX/UI Design',
      'category': 'Design',
      'rating': 4.8,
      'reviews': 89,
      'experience': '6 years',
      'company': 'Adobe',
      'price': '\$45/hour',
      'languages': ['English', 'Mandarin'],
      'availability': 'Available tomorrow',
      'image': 'assets/images/mentor2.jpg',
    },
    {
      'name': 'Dr. Emily Rodriguez',
      'expertise': 'Data Science',
      'category': 'Technology',
      'rating': 4.9,
      'reviews': 156,
      'experience': '10 years',
      'company': 'Microsoft',
      'price': '\$60/hour',
      'languages': ['English', 'Portuguese'],
      'availability': 'Available now',
      'image': 'assets/images/mentor3.jpg',
    },
    {
      'name': 'James Thompson',
      'expertise': 'Product Management',
      'category': 'Business',
      'rating': 4.7,
      'reviews': 203,
      'experience': '12 years',
      'company': 'Amazon',
      'price': '\$55/hour',
      'languages': ['English'],
      'availability': 'Busy',
      'image': 'assets/images/mentor4.jpg',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredMentors {
    return _mentors.where((mentor) {
      final matchesCategory =
          _selectedCategory == 'All' || mentor['category'] == _selectedCategory;
      final matchesSearch =
          _searchController.text.isEmpty ||
          mentor['name'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          mentor['expertise'].toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Find Mentors'),
        actions: [
          IconButton(
            onPressed: () {
              // Show filter options
            },
            icon: const Icon(Icons.filter_list, color: kOnSurface),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search mentors by name or expertise...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),

          // Category Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;

                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    backgroundColor: kSurfaceVariant,
                    selectedColor: kPrimaryContainer,
                    labelStyle: TextStyle(
                      color: isSelected ? kPrimary : kOnSurfaceVariant,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Mentors Grid
          Expanded(
            child: _filteredMentors.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: kOnSurfaceVariant,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No mentors found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: kOnSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Try adjusting your search or filters',
                          style: TextStyle(color: kOnSurfaceVariant),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: _filteredMentors.length,
                    itemBuilder: (context, index) {
                      return _buildMentorCard(_filteredMentors[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorCard(Map<String, dynamic> mentor) {
    return customCard(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: kPrimaryContainer,
              borderRadius: BorderRadius.circular(16),
              image: mentor['image'] != null
                  ? DecorationImage(
                      image: AssetImage(mentor['image']),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: mentor['image'] == null
                ? const Icon(Icons.person, size: 40, color: kPrimary)
                : null,
          ),

          const SizedBox(width: 16),

          // Mentor Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        mentor['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: mentor['availability'] == 'Available now'
                            ? kSuccess.withOpacity(0.1)
                            : mentor['availability'] == 'Available tomorrow'
                            ? kWarning.withOpacity(0.1)
                            : kError.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        mentor['availability'],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: mentor['availability'] == 'Available now'
                              ? kSuccess
                              : mentor['availability'] == 'Available tomorrow'
                              ? kWarning
                              : kError,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  mentor['expertise'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kPrimary,
                  ),
                ),

                Text(
                  '${mentor['company']} • ${mentor['experience']}',
                  style: const TextStyle(fontSize: 12, color: kOnSurfaceVariant),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: kWarning),
                    const SizedBox(width: 4),
                    Text(
                      '${mentor['rating']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ' (${mentor['reviews']} reviews)',
                      style: const TextStyle(fontSize: 12, color: kOnSurfaceVariant),
                    ),
                    const Spacer(),
                    Text(
                      mentor['price'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: kPrimary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Languages
                Wrap(
                  spacing: 4,
                  children: (mentor['languages'] as List<String>).map((lang) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        lang,
                        style: const TextStyle(
                          fontSize: 10,
                          color: kOnSecondaryContainer,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Action Button
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: FilledButton(
                  onPressed: mentor['availability'] != 'Busy'
                      ? () => _showRequestDialog(mentor)
                      : null,
                  child: const Text('Request'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 120,
                child: OutlinedButton(
                  onPressed: () => _showMentorProfile(mentor),
                  child: const Text('View Profile'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRequestDialog(Map<String, dynamic> mentor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Mentorship'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send a mentorship request to ${mentor['name']}?'),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Message (optional)',
                hintText: 'Tell them about your goals...',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Request sent to ${mentor['name']}'),
                  backgroundColor: kSuccess,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Send Request'),
          ),
        ],
      ),
    );
  }

  void _showMentorProfile(Map<String, dynamic> mentor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: kOnSurfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Profile Header
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: kPrimaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.person, size: 40, color: kPrimary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mentor['name'],
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            mentor['expertise'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: kPrimary,
                            ),
                          ),
                          Text(
                            '${mentor['company']} • ${mentor['experience']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: kOnSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildProfileStat(
                        icon: Icons.star,
                        value: '${mentor['rating']}',
                        label: 'Rating',
                      ),
                    ),
                    Expanded(
                      child: _buildProfileStat(
                        icon: Icons.rate_review,
                        value: '${mentor['reviews']}',
                        label: 'Reviews',
                      ),
                    ),
                    Expanded(
                      child: _buildProfileStat(
                        icon: Icons.schedule,
                        value: mentor['experience'],
                        label: 'Experience',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Bio Section
                Text(
                  'About',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  'Experienced ${mentor['expertise']} professional with ${mentor['experience']} at ${mentor['company']}. Passionate about mentoring and helping students achieve their career goals.',
                  style: const TextStyle(color: kOnSurfaceVariant, height: 1.5),
                ),

                const SizedBox(height: 24),

                // Languages
                Text(
                  'Languages',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: (mentor['languages'] as List<String>).map((lang) {
                    return Chip(
                      label: Text(lang),
                      backgroundColor: kSecondaryContainer,
                    );
                  }).toList(),
                ),

                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _showRequestDialog(mentor);
                        },
                        child: const Text('Request Mentorship'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStat({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: kPrimary),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: kOnSurfaceVariant)),
      ],
    );
  }
}

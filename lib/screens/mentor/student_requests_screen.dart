import 'package:flutter/material.dart';
import '../../theme.dart';

class StudentRequestsScreen extends StatefulWidget {
  const StudentRequestsScreen({super.key});

  @override
  State<StudentRequestsScreen> createState() => _StudentRequestsScreenState();
}

class _StudentRequestsScreenState extends State<StudentRequestsScreen> {
  String selectedDomain = 'All';
  final List<String> domains = [
    'All',
    'Technology',
    'Design',
    'Medicine',
    'Business',
    'Engineering',
    'Arts',
  ];

  final List<Map<String, dynamic>> pendingRequests = [
    {
      'student': 'Alex Chen',
      'level': 'Class 12',
      'domain': 'Technology',
      'goal': 'Want to pursue Computer Science and learn about software development career paths.',
      'interests': ['Programming', 'AI', 'Web Development'],
    },
    {
      'student': 'Maria Garcia',
      'level': 'Class 10',
      'domain': 'Medicine',
      'goal': 'Interested in becoming a doctor and understanding medical career options.',
      'interests': ['Biology', 'Healthcare', 'Research'],
    },
    {
      'student': 'John Smith',
      'level': 'Class 12',
      'domain': 'Design',
      'goal': 'Passionate about UI/UX design and want guidance on design career.',
      'interests': ['Design', 'Art', 'User Experience'],
    },
    {
      'student': 'Emma Wilson',
      'level': 'Class 11',
      'domain': 'Business',
      'goal': 'Interested in entrepreneurship and business management.',
      'interests': ['Business', 'Leadership', 'Marketing'],
    },
    {
      'student': 'David Kim',
      'level': 'Class 12',
      'domain': 'Engineering',
      'goal': 'Want to understand different engineering fields and career prospects.',
      'interests': ['Mathematics', 'Physics', 'Technology'],
    },
  ];

  List<Map<String, dynamic>> get filteredRequests {
    if (selectedDomain == 'All') {
      return pendingRequests;
    }
    return pendingRequests
        .where((request) => request['domain'] == selectedDomain)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Requests',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: kGradientStart,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'Filter by Domain:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedDomain,
                    isExpanded: true,
                    underline: Container(),
                    items: domains.map((domain) {
                      return DropdownMenuItem(
                        value: domain,
                        child: Text(domain),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDomain = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Requests List
          Expanded(
            child: filteredRequests.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No requests found for $selectedDomain',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Student Info
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kGradientStart,
                                    child: Text(
                                      request['student'][0],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          request['student'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          request['level'],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kGradientStart.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      request['domain'],
                                      style: const TextStyle(
                                        color: kGradientStart,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              
                              // Goal Description
                              const Text(
                                'Goal:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                request['goal'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 12),
                              
                              // Interests
                              const Text(
                                'Interests:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: request['interests']
                                    .map<Widget>((interest) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            interest,
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                              const SizedBox(height: 16),
                              
                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _rejectRequest(request['student']),
                                      icon: const Icon(Icons.close, size: 16),
                                      label: const Text('Reject'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[50],
                                        foregroundColor: Colors.red,
                                        elevation: 0,
                                        side: BorderSide(color: Colors.red[200]!),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () => _acceptRequest(request['student']),
                                      icon: const Icon(Icons.check, size: 16),
                                      label: const Text('Accept'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kGradientStart,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _acceptRequest(String studentName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accept Request'),
        content: Text('Accept mentoring request from $studentName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Request from $studentName accepted!'),
                  backgroundColor: Colors.green,
                ),
              );
              // Remove from pending requests in real implementation
            },
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }

  void _rejectRequest(String studentName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Request'),
        content: Text('Reject mentoring request from $studentName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Request from $studentName rejected.'),
                  backgroundColor: Colors.red,
                ),
              );
              // Remove from pending requests in real implementation
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }
}

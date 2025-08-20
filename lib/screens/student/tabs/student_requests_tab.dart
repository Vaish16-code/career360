import 'package:flutter/material.dart';
import '../../../theme.dart';

class StudentRequestsTab extends StatefulWidget {
  const StudentRequestsTab({super.key});

  @override
  State<StudentRequestsTab> createState() => _StudentRequestsTabState();
}

class _StudentRequestsTabState extends State<StudentRequestsTab> {
  final List<Map<String, dynamic>> _requests = [
    {
      'id': '1',
      'mentor': 'Dr. Sarah Wilson',
      'expertise': 'Software Engineering',
      'status': 'pending',
      'requestDate': '2024-01-15',
      'message':
          'I would love to learn about software architecture and best practices.',
      'response': null,
    },
    {
      'id': '2',
      'mentor': 'Michael Chen',
      'expertise': 'UX/UI Design',
      'status': 'approved',
      'requestDate': '2024-01-12',
      'message':
          'Looking for guidance in transitioning from development to design.',
      'response': 'I\'d be happy to help you with your design journey!',
    },
    {
      'id': '3',
      'mentor': 'James Thompson',
      'expertise': 'Product Management',
      'status': 'rejected',
      'requestDate': '2024-01-10',
      'message': 'Interested in learning product strategy and roadmapping.',
      'response': 'Unfortunately, I\'m fully booked for the next few months.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Requests'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          return _buildRequestCard(_requests[index]);
        },
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (request['status']) {
      case 'pending':
        statusColor = kWarning;
        statusText = 'Pending';
        statusIcon = Icons.schedule;
        break;
      case 'approved':
        statusColor = kSuccess;
        statusText = 'Approved';
        statusIcon = Icons.check_circle;
        break;
      case 'rejected':
        statusColor = kError;
        statusText = 'Rejected';
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = kOnSurfaceVariant;
        statusText = 'Unknown';
        statusIcon = Icons.help;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: customCard(
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: kPrimaryContainer,
                  child: Icon(Icons.person, color: kPrimary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request['mentor'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        request['expertise'],
                        style: TextStyle(
                          fontSize: 14,
                          color: kOnSurfaceVariant,
                        ),
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
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 16, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Request Message
            Text(
              'Your Message:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kOnSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(request['message'], style: const TextStyle(fontSize: 14)),

            // Response (if any)
            if (request['response'] != null) ...[
              const SizedBox(height: 12),
              Text(
                'Mentor Response:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: kOnSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kSurfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  request['response'],
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Footer
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: kOnSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  'Requested on ${request['requestDate']}',
                  style: TextStyle(fontSize: 12, color: kOnSurfaceVariant),
                ),
                const Spacer(),
                if (request['status'] == 'approved')
                  TextButton(
                    onPressed: () {
                      // Navigate to scheduling
                    },
                    child: const Text('Schedule Session'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

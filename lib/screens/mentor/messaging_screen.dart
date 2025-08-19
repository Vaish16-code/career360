import 'package:flutter/material.dart';
import '../../theme.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  String? selectedStudentId;
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> students = [
    {
      'id': '1',
      'name': 'Alex Chen',
      'lastMessage': 'Thank you for the session!',
      'time': '2:30 PM',
      'unread': 2,
      'online': true,
    },
    {
      'id': '2',
      'name': 'Maria Garcia',
      'lastMessage': 'When is our next meeting?',
      'time': '1:15 PM',
      'unread': 1,
      'online': false,
    },
    {
      'id': '3',
      'name': 'John Smith',
      'lastMessage': 'I completed the assignment',
      'time': '11:45 AM',
      'unread': 0,
      'online': true,
    },
    {
      'id': '4',
      'name': 'Emma Wilson',
      'lastMessage': 'Can you share the resources?',
      'time': 'Yesterday',
      'unread': 0,
      'online': false,
    },
  ];

  final Map<String, List<Map<String, dynamic>>> chatMessages = {
    '1': [
      {
        'text': 'Hi! Looking forward to our session today.',
        'isMe': false,
        'time': '2:00 PM',
      },
      {
        'text': 'Hello Alex! Yes, I\'m ready. Do you have any specific topics you\'d like to discuss?',
        'isMe': true,
        'time': '2:05 PM',
      },
      {
        'text': 'I want to learn about career paths in AI and machine learning.',
        'isMe': false,
        'time': '2:06 PM',
      },
      {
        'text': 'Perfect! That\'s exactly my area of expertise. Let\'s start with the fundamentals.',
        'isMe': true,
        'time': '2:07 PM',
      },
      {
        'text': 'Thank you for the session!',
        'isMe': false,
        'time': '2:30 PM',
      },
    ],
    '2': [
      {
        'text': 'Hello! I have some questions about the career planning we discussed.',
        'isMe': false,
        'time': '1:00 PM',
      },
      {
        'text': 'Of course! What would you like to know?',
        'isMe': true,
        'time': '1:05 PM',
      },
      {
        'text': 'When is our next meeting?',
        'isMe': false,
        'time': '1:15 PM',
      },
    ],
    '3': [
      {
        'text': 'I completed the assignment you gave me.',
        'isMe': false,
        'time': '11:45 AM',
      },
      {
        'text': 'Great! I\'ll review it and give you feedback soon.',
        'isMe': true,
        'time': '11:50 AM',
      },
    ],
    '4': [
      {
        'text': 'Can you share the resources we talked about?',
        'isMe': false,
        'time': 'Yesterday',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedStudentId == null 
              ? 'Messages' 
              : students.firstWhere((s) => s['id'] == selectedStudentId)['name'],
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: kGradientStart,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        leading: selectedStudentId != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: kGradientStart),
                onPressed: () {
                  setState(() {
                    selectedStudentId = null;
                  });
                },
              )
            : null,
        actions: selectedStudentId != null
            ? [
                IconButton(
                  icon: const Icon(Icons.videocam, color: kGradientStart),
                  onPressed: _startVideoCall,
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: kGradientStart),
                  onPressed: _startVoiceCall,
                ),
              ]
            : null,
      ),
      body: Row(
        children: [
          // Student List (left side)
          if (MediaQuery.of(context).size.width > 600 || selectedStudentId == null)
            Container(
              width: MediaQuery.of(context).size.width > 600 
                  ? 300 
                  : MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search students...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  
                  // Students List
                  Expanded(
                    child: ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        final isSelected = selectedStudentId == student['id'];
                        
                        return Container(
                          color: isSelected ? kGradientStart.withValues(alpha: 0.1) : null,
                          child: ListTile(
                            leading: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: kGradientStart,
                                  child: Text(
                                    student['name'][0],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (student['online'])
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    student['name'],
                                    style: TextStyle(
                                      fontWeight: student['unread'] > 0 
                                          ? FontWeight.w700 
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                                if (student['unread'] > 0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: kGradientStart,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      student['unread'].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    student['lastMessage'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: student['unread'] > 0 
                                          ? Colors.black87 
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                Text(
                                  student['time'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                selectedStudentId = student['id'];
                                // Mark as read
                                student['unread'] = 0;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          
          // Chat Area (right side)
          if (MediaQuery.of(context).size.width > 600 || selectedStudentId != null)
            Expanded(
              child: selectedStudentId == null
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Select a student to start chatting',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : _buildChatArea(),
            ),
        ],
      ),
    );
  }

  Widget _buildChatArea() {
    final messages = chatMessages[selectedStudentId] ?? [];
    
    return Column(
      children: [
        // Messages
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isMe = message['isMe'];
              
              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? kGradientStart : Colors.grey[200],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message['text'],
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message['time'],
                        style: TextStyle(
                          fontSize: 10,
                          color: isMe ? Colors.white70 : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        // Message Input
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: _attachFile,
                icon: const Icon(Icons.attach_file, color: kGradientStart),
              ),
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                onPressed: _sendMessage,
                backgroundColor: kGradientStart,
                mini: true,
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      chatMessages[selectedStudentId]?.add({
        'text': _messageController.text.trim(),
        'isMe': true,
        'time': 'Now',
      });
    });
    
    _messageController.clear();
  }

  void _attachFile() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo, color: kGradientStart),
              title: const Text('Photo'),
              onTap: () {
                Navigator.pop(context);
                _showComingSoon('Photo attachment');
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: kGradientStart),
              title: const Text('Video'),
              onTap: () {
                Navigator.pop(context);
                _showComingSoon('Video attachment');
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_file, color: kGradientStart),
              title: const Text('Document'),
              onTap: () {
                Navigator.pop(context);
                _showComingSoon('Document attachment');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _startVideoCall() {
    _showComingSoon('Video call');
  }

  void _startVoiceCall() {
    _showComingSoon('Voice call');
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature feature coming soon!')),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

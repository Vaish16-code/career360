import 'package:flutter/material.dart';
import '../../../theme.dart';

class StudentMessagesTab extends StatefulWidget {
  const StudentMessagesTab({super.key});

  @override
  State<StudentMessagesTab> createState() => _StudentMessagesTabState();
}

class _StudentMessagesTabState extends State<StudentMessagesTab> {
  final List<Map<String, dynamic>> _conversations = [
    {
      'id': '1',
      'mentor': 'Dr. Sarah Wilson',
      'lastMessage': 'Great! Let\'s schedule our next session for Thursday.',
      'timestamp': '2 min ago',
      'unread': 2,
      'online': true,
    },
    {
      'id': '2',
      'mentor': 'Michael Chen',
      'lastMessage': 'I\'ve shared some design resources with you.',
      'timestamp': '1 hour ago',
      'unread': 0,
      'online': false,
    },
    {
      'id': '3',
      'mentor': 'Dr. Emily Rodriguez',
      'lastMessage': 'How did the data science project go?',
      'timestamp': 'Yesterday',
      'unread': 1,
      'online': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Messages'),
        actions: [
          IconButton(
            onPressed: () {
              // Show compose options
            },
            icon: const Icon(Icons.edit, color: kOnSurface),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          return _buildConversationCard(_conversations[index]);
        },
      ),
    );
  }

  Widget _buildConversationCard(Map<String, dynamic> conversation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: customCard(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: () => _openChat(conversation),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: kPrimaryContainer,
                      child: Icon(Icons.person, color: kPrimary),
                    ),
                    if (conversation['online'])
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: kSuccess,
                            shape: BoxShape.circle,
                            border: Border.all(color: kSurface, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation['mentor'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            conversation['timestamp'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: kOnSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        conversation['lastMessage'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: kOnSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                if (conversation['unread'] > 0) ...[
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: kPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${conversation['unread']}',
                      style: const TextStyle(
                        color: kOnPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openChat(Map<String, dynamic> conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(conversation: conversation),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hi! I\'m excited to start working with you.',
      'isMe': true,
      'timestamp': '10:30 AM',
    },
    {
      'text':
          'Hello! I\'m looking forward to our mentoring sessions. What specific areas would you like to focus on?',
      'isMe': false,
      'timestamp': '10:32 AM',
    },
    {
      'text':
          'I\'m particularly interested in software architecture and design patterns.',
      'isMe': true,
      'timestamp': '10:35 AM',
    },
    {
      'text':
          'Perfect! Those are crucial topics. Let\'s start with the fundamentals of clean architecture.',
      'isMe': false,
      'timestamp': '10:37 AM',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text.trim(),
        'isMe': true,
        'timestamp': 'Now',
      });
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  backgroundColor: kPrimaryContainer,
                  child: Icon(Icons.person, color: kPrimary, size: 20),
                ),
                if (widget.conversation['online'])
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: kSuccess,
                        shape: BoxShape.circle,
                        border: Border.all(color: kSurface, width: 1),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.conversation['mentor'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.conversation['online'])
                  const Text(
                    'Online',
                    style: TextStyle(
                      fontSize: 12,
                      color: kSuccess,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Video call
            },
            icon: const Icon(Icons.videocam, color: kOnSurface),
          ),
          IconButton(
            onPressed: () {
              // Voice call
            },
            icon: const Icon(Icons.call, color: kOnSurface),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kSurface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Attach file
                  },
                  icon: const Icon(Icons.attach_file, color: kOnSurfaceVariant),
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
                      fillColor: kSurfaceVariant.withOpacity(0.3),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    maxLines: null,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [kGradientStart, kGradientEnd],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, color: kOnPrimary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final isMe = message['isMe'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            const CircleAvatar(
              radius: 16,
              backgroundColor: kPrimaryContainer,
              child: Icon(Icons.person, size: 16, color: kPrimary),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? kPrimary : kSurfaceVariant,
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomLeft: isMe
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: isMe
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['text'],
                    style: TextStyle(
                      color: isMe ? kOnPrimary : kOnSurface,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message['timestamp'],
                    style: TextStyle(
                      color: isMe
                          ? kOnPrimary.withOpacity(0.7)
                          : kOnSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 16,
              backgroundColor: kPrimaryContainer,
              child: Icon(Icons.person, size: 16, color: kPrimary),
            ),
          ],
        ],
      ),
    );
  }
}

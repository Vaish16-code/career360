import 'package:flutter/material.dart';
import '../../theme.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final List<Map<String, dynamic>> uploadedResources = [
    {
      'title': 'Software Engineering Career Guide',
      'type': 'PDF',
      'uploadDate': 'Aug 15, 2025',
      'downloads': 23,
      'icon': Icons.picture_as_pdf,
      'color': Colors.red,
    },
    {
      'title': 'Introduction to Web Development',
      'type': 'Video',
      'uploadDate': 'Aug 12, 2025',
      'downloads': 15,
      'icon': Icons.play_circle,
      'color': Colors.blue,
    },
    {
      'title': 'Tech Interview Tips & Tricks',
      'type': 'Article',
      'uploadDate': 'Aug 10, 2025',
      'downloads': 31,
      'icon': Icons.article,
      'color': Colors.green,
    },
    {
      'title': 'Programming Languages Comparison',
      'type': 'PDF',
      'uploadDate': 'Aug 8, 2025',
      'downloads': 18,
      'icon': Icons.picture_as_pdf,
      'color': Colors.red,
    },
  ];

  final List<Map<String, dynamic>> quickLinks = [
    {
      'title': 'Coding Interview Prep',
      'description': 'Practice problems and solutions',
      'icon': Icons.code,
      'color': Colors.purple,
    },
    {
      'title': 'Industry Trends 2025',
      'description': 'Latest technology trends',
      'icon': Icons.trending_up,
      'color': Colors.orange,
    },
    {
      'title': 'Mentoring Best Practices',
      'description': 'Tips for effective mentoring',
      'icon': Icons.school,
      'color': Colors.teal,
    },
    {
      'title': 'Career Path Templates',
      'description': 'Structured career planning',
      'icon': Icons.route,
      'color': Colors.indigo,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resources & Tools',
          style: TextStyle(fontWeight: FontWeight.w800, color: kGradientStart),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kGradientStart, kGradientEnd],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Share Resources',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Upload and share resources with your students',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildUploadButton(
                          'Upload PDF',
                          Icons.picture_as_pdf,
                          () => _uploadResource('PDF'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildUploadButton(
                          'Upload Video',
                          Icons.videocam,
                          () => _uploadResource('Video'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildUploadButton(
                          'Add Article',
                          Icons.article,
                          () => _uploadResource('Article'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Uploaded Resources Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Uploaded Resources',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () => _manageResources(),
                    child: const Text('Manage All'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: uploadedResources.length,
              itemBuilder: (context, index) {
                final resource = uploadedResources[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: resource['color'].withValues(alpha: 0.1),
                      child: Icon(resource['icon'], color: resource['color']),
                    ),
                    title: Text(
                      resource['title'],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${resource['type']}'),
                        Text('Uploaded: ${resource['uploadDate']}'),
                        Text('Downloads: ${resource['downloads']}'),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'view',
                          child: Row(
                            children: [
                              Icon(Icons.visibility, size: 18),
                              SizedBox(width: 8),
                              Text('View'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) =>
                          _handleResourceAction(value.toString(), resource),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Quick Links Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Quick Links & Tools',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: quickLinks.length,
              itemBuilder: (context, index) {
                final link = quickLinks[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () => _openQuickLink(link['title']),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: link['color'].withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              link['icon'],
                              color: link['color'],
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            link['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            link['description'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton(String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: kGradientStart,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _uploadResource(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upload $type'),
        content: Text('$type upload feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _manageResources() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manage Resources'),
        content: const Text('Resource management feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleResourceAction(String action, Map<String, dynamic> resource) {
    switch (action) {
      case 'view':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Viewing ${resource['title']}')));
        break;
      case 'edit':
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Editing ${resource['title']}')));
        break;
      case 'delete':
        _deleteResource(resource);
        break;
    }
  }

  void _deleteResource(Map<String, dynamic> resource) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Resource'),
        content: Text(
          'Are you sure you want to delete "${resource['title']}"?',
        ),
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
                  content: Text('${resource['title']} deleted'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _openQuickLink(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('$title feature coming soon!'),
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

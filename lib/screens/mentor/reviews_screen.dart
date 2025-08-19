import 'package:flutter/material.dart';
import '../../theme.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  final List<Map<String, dynamic>> reviews = const [
    {
      'student': 'Alex Chen',
      'date': 'Aug 18, 2025',
      'rating': 5,
      'comment':
          'Dr. Sarah is an amazing mentor! She helped me understand the software engineering field and gave me clear guidance on my career path. Her insights are invaluable.',
      'session': 'Career Planning Session',
    },
    {
      'student': 'Maria Garcia',
      'date': 'Aug 16, 2025',
      'rating': 5,
      'comment':
          'Excellent mentoring session. Very knowledgeable and patient. She answered all my questions about getting into tech and provided great resources.',
      'session': 'Tech Industry Overview',
    },
    {
      'student': 'Emma Wilson',
      'date': 'Aug 15, 2025',
      'rating': 4,
      'comment':
          'Great session! Really helpful advice on portfolio building and interview preparation. Looking forward to more sessions.',
      'session': 'Portfolio Review',
    },
    {
      'student': 'David Kim',
      'date': 'Aug 14, 2025',
      'rating': 5,
      'comment':
          'Dr. Sarah provided excellent guidance on choosing the right programming languages to learn. Her real-world experience really shows.',
      'session': 'Technical Skills Discussion',
    },
    {
      'student': 'John Smith',
      'date': 'Aug 12, 2025',
      'rating': 4,
      'comment':
          'Very insightful session about the current job market in tech. Got great tips on how to stand out as a candidate.',
      'session': 'Job Market Analysis',
    },
    {
      'student': 'Sofia Rodriguez',
      'date': 'Aug 10, 2025',
      'rating': 5,
      'comment':
          'Amazing mentor! She helped me create a clear roadmap for my career transition into tech. Highly recommend!',
      'session': 'Career Transition Planning',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate overall rating
    final totalRating = reviews.fold<double>(
      0.0,
      (sum, review) => sum + review['rating'],
    );
    final averageRating = totalRating / reviews.length;

    // Rating distribution
    final ratingCounts = <int, int>{};
    for (final review in reviews) {
      final rating = review['rating'] as int;
      ratingCounts[rating] = (ratingCounts[rating] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews & Feedback',
          style: TextStyle(fontWeight: FontWeight.w800, color: kGradientStart),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Rating Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kGradientStart, kGradientEnd],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Overall Rating',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < averageRating.floor()
                            ? Icons.star
                            : (index < averageRating
                                  ? Icons.star_half
                                  : Icons.star_border),
                        color: Colors.white,
                        size: 24,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Based on ${reviews.length} reviews',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Rating Distribution
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rating Distribution',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(5, (index) {
                        final rating = 5 - index;
                        final count = ratingCounts[rating] ?? 0;
                        final percentage = count / reviews.length;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              Text('$rating'),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: percentage,
                                  backgroundColor: Colors.grey[200],
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        kGradientStart,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 30,
                                child: Text(
                                  count.toString(),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Reviews List
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Recent Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with student info and rating
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: kGradientStart,
                              child: Text(
                                review['student'][0],
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
                                    review['student'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    review['date'],
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kGradientStart.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      review['session'],
                                      style: const TextStyle(
                                        color: kGradientStart,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(5, (starIndex) {
                                    return Icon(
                                      starIndex < review['rating']
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.amber,
                                      size: 18,
                                    );
                                  }),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${review['rating']}/5',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Review Comment
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            review['comment'],
                            style: const TextStyle(fontSize: 14, height: 1.4),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () => _replyToReview(context, review),
                              icon: const Icon(Icons.reply, size: 16),
                              label: const Text('Reply'),
                              style: TextButton.styleFrom(
                                foregroundColor: kGradientStart,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => _shareReview(context, review),
                              icon: const Icon(Icons.share, size: 16),
                              label: const Text('Share'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.grey[600],
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _replyToReview(BuildContext context, Map<String, dynamic> review) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reply to ${review['student']}'),
        content: const TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Write your reply...',
            border: OutlineInputBorder(),
          ),
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
                const SnackBar(
                  content: Text('Reply sent successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send Reply'),
          ),
        ],
      ),
    );
  }

  void _shareReview(BuildContext context, Map<String, dynamic> review) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share review feature coming soon!')),
    );
  }
}

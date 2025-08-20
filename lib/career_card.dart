import 'package:flutter/material.dart';
import '../mock_data.dart'; // import your Career model

class CareerCard extends StatelessWidget {
  final Career career;
  final VoidCallback? onReject;
  final VoidCallback? onWhy;

  const CareerCard({
    super.key,
    required this.career,
    this.onReject,
    this.onWhy,
  });

  Color _getConfidenceColor(int confidence) {
    if (confidence >= 90) return Colors.green.shade100;
    if (confidence >= 75) return Colors.orange.shade100;
    return Colors.blue.shade100;
  }

  Color _getConfidenceTextColor(int confidence) {
    if (confidence >= 90) return Colors.green.shade800;
    if (confidence >= 75) return Colors.orange.shade800;
    return Colors.blue.shade800;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title + Confidence Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      career.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      career.category,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getConfidenceColor(career.confidence),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${career.confidence}% Match",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _getConfidenceTextColor(career.confidence),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Description
            Text(
              career.description,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
            ),

            const SizedBox(height: 16),

            /// Skills
            _buildChipsSection("Key Skills", career.skills, Colors.blue),

            const SizedBox(height: 12),

            /// Subjects
            _buildChipsSection("Subjects", career.subjects, Colors.purple),

            const SizedBox(height: 12),

            /// Colleges
            Row(
              children: const [
                Icon(Icons.school, size: 18),
                SizedBox(width: 6),
                Text(
                  "Top Colleges",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ],
            ),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: career.topColleges
                  .map(
                    (college) => Chip(
                      label: Text(college),
                      backgroundColor: Colors.grey.shade200,
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 16),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReject,
                    icon: const Icon(Icons.thumb_down),
                    label: const Text("Not for me"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onWhy,
                    icon: const Icon(Icons.help_outline),
                    label: const Text("Why?"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipsSection(
    String title,
    List<String> items,
    MaterialColor color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: items
              .map(
                (item) => Chip(
                  label: Text(item),
                  backgroundColor: color.shade100, // ✅ lighter shade
                  labelStyle: TextStyle(
                    color: color.shade700,
                    fontSize: 12,
                  ), // ✅ darker shade
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:career360/mock_data.dart'; // Import your mock data
import 'package:career360/career_card.dart'; // Import your CareerCard widget

class StudentCareers extends StatefulWidget {
  const StudentCareers({super.key});

  @override
  StudentCareersState createState() => StudentCareersState();
}

class StudentCareersState extends State<StudentCareers> {
  bool showReplaySheet = false;
  String? selectedCareer;

  void handleReject(String careerId) {
    setState(() {
      selectedCareer = careerId;
      showReplaySheet = true;
    });
  }

  void handleWhy(String careerId) {
    debugPrint('Show why for career: $careerId'); // ✅ replaced print
    // Show detailed career explanation
  }

  void handleReplayOption(String option) {
    debugPrint('Selected replay option: $option');
    setState(() {
      showReplaySheet = false;
    });
    // Navigate based on option
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.withOpacity(0.05), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                // Header
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.green],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.psychology, size: 28, color: Colors.white),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Career Recommendations',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Personalized career paths based on your game performance',
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.filter_list),
                            label: const Text('Filter'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.refresh),
                            label: const Text('Refresh'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Match Summary
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  '🎯 Your Career Match',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 100, // ✅ prevents GridView overflow
                            child: GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _buildMatchSummaryItem(
                                  '3',
                                  'High Matches',
                                  Colors.green,
                                ),
                                _buildMatchSummaryItem(
                                  '2',
                                  'Medium Matches',
                                  Colors.orange,
                                ),
                                _buildMatchSummaryItem(
                                  '85%',
                                  'Avg Confidence',
                                  Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Career Recommendations
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recommended For You',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: mockCareers.map((career) {
                          return CareerCard(
                            career: career,
                            onReject: () => handleReject(career.id),
                            onWhy: () => handleWhy(career.id),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // Improve Recommendations
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Expanded(
                              child: Text(
                                '🚀 Want Better Recommendations?',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Play more games to get increasingly personalized career suggestions!',
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.videogame_asset),
                              label: const Text('Play Games'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.quiz),
                              label: const Text('Take Quiz'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Tips Card
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '💡 Pro Tips',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: [
                            _buildTip(
                              'Higher match percentages mean the career aligns better with your assessed skills and interests.',
                            ),
                            _buildTip(
                              'Click "Why?" to understand how we matched you to each career.',
                            ),
                            _buildTip(
                              'Use "Not for me" to help us learn your preferences better.',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: showReplaySheet ? _buildReplaySheet() : null,
    );
  }

  static Widget _buildMatchSummaryItem(
    String value,
    String label,
    Color color,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  static Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildReplaySheet() {
    return Container(
      height: 300,
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Career Not Right for You?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Let\'s help you get better recommendations. What would you like to do?',
            ),
          ),
          ListTile(
            title: const Text('Replay Assessment Games'),
            onTap: () => handleReplayOption('replay'),
          ),
          ListTile(
            title: const Text('Take Deep-Dive Quiz'),
            onTap: () => handleReplayOption('deepdive'),
          ),
          ListTile(
            title: const Text('Quick Questions'),
            onTap: () => handleReplayOption('quick'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                showReplaySheet = false;
              });
            },
            child: const Text('Maybe Later'),
          ),
        ],
      ),
    );
  }
}

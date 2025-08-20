import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Dummy user data (replace with DB later)
  final Map<String, dynamic> userData = {
    "name": "Alex Kumar",
    "grade": "10th Grade",
    "age": 16,
    "email": "alex@example.com",
    "level": 12,
    "xp": 2450,
    "rank": 23,
    "progress": 50,
    "nextLevelXP": 200,
    "interests": ["Technology", "Science", "Art"],
    "badges": [
      {"title": "Explorer", "date": "1/15/2024", "earned": true},
      {"title": "Problem Solver", "date": "2/3/2024", "earned": true},
      {"title": "Creative Thinker", "date": "", "earned": false},
      {"title": "Streak Master", "date": "", "earned": false},
    ],
    "streak": 7,
    "gamesCompleted": 3,
    "badgesEarned": 2,
    "recentAchievement": {
      "title": "Problem Solver",
      "date": "3 days ago",
      "desc": "Solved 10 logic puzzles successfully"
    }
  };

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  // Load image path from SharedPreferences
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('profileImage');
    if (savedPath != null && File(savedPath).existsSync()) {
      setState(() {
        _profileImage = File(savedPath);
      });
    }
  }

  // Save image path
  Future<void> _saveProfileImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImage', path);
  }

  // Pick from gallery
  Future<void> _pickFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _saveProfileImage(pickedFile.path);
    }
  }

  // Pick from camera
  Future<void> _pickFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      _saveProfileImage(pickedFile.path);
    }
  }

  // Show bottom sheet for choosing
  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickFromCamera();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- User Header ---
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _showImagePickerDialog,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : const AssetImage("assets/default_profile.png") as ImageProvider,
                            child: const Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.camera_alt, size: 16, color: Colors.deepPurple),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userData["name"], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text("${userData["grade"]} • ${userData["age"]} years old"),
                            Text(userData["email"]),
                          ],
                        ),
                        const Spacer(),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [Text("Level ${userData["level"]}", style: const TextStyle(fontWeight: FontWeight.bold)), const Text("Current Level")]),
                        Column(children: [Text("${userData["xp"]}", style: const TextStyle(fontWeight: FontWeight.bold)), const Text("Total XP")]),
                        Column(children: [Text("#${userData["rank"]}", style: const TextStyle(fontWeight: FontWeight.bold)), const Text("Leaderboard")]),
                      ],
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Level Progress ---
            const Text("Level Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            LinearProgressIndicator(
              value: userData["progress"] / userData["nextLevelXP"],
              color: Colors.deepPurple,
              minHeight: 8,
            ),
            Text("You need ${userData["nextLevelXP"] - userData["progress"]} more XP to reach next level!"),

            const SizedBox(height: 20),

            // --- Interests ---
            const Text("Your Interests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: userData["interests"].map<Widget>((interest) => Chip(label: Text(interest))).toList(),
            ),

            const SizedBox(height: 20),

            // --- Badge Collection ---
            const Text("Badge Collection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: userData["badges"].map<Widget>((badge) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: badge["earned"] ? Colors.deepPurple : Colors.grey[300],
                          radius: 30,
                          child: const Icon(Icons.emoji_events, color: Colors.white),
                        ),
                        const SizedBox(height: 6),
                        Text(badge["title"]),
                        if (badge["earned"]) Text(badge["date"], style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // --- Statistics ---
            const Text("Your Statistics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [Text("${userData["streak"]} days", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)), const Text("Current Streak")]),
                Column(children: [Text("${userData["badgesEarned"]}", style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)), const Text("Badges Earned")]),
                Column(children: [Text("${userData["gamesCompleted"]}", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)), const Text("Games Completed")]),
                Column(children: [Text("#${userData["rank"]}", style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)), const Text("Rank")]),
              ],
            ),

            const SizedBox(height: 20),

            // --- Quick Actions ---
            const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const ListTile(leading: Icon(Icons.settings), title: Text("Account Settings")),
            const ListTile(leading: Icon(Icons.badge), title: Text("View All Badges")),
            const ListTile(leading: Icon(Icons.leaderboard), title: Text("Leaderboard")),

            const SizedBox(height: 20),

            // --- Recent Achievement ---
            const Text("Recent Achievement", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Card(
              color: Colors.deepPurple[50],
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.extension, color: Colors.white),
                ),
                title: Text(userData["recentAchievement"]["title"]),
                subtitle: Text("${userData["recentAchievement"]["desc"]}\nEarned ${userData["recentAchievement"]["date"]}"),
              ),
            ),

            const SizedBox(height: 20),

            // --- Sign Out ---
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text("Sign Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  final String id;
  final String name;
  final int age;
  final String studentClass; // '10th' | '12th'
  final List<String> interests;
  final String email;
  final int xp;
  final int level;
  final int streak;
  final List<Badge> badges;
  final int leaderboardRank;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.studentClass,
    required this.interests,
    required this.email,
    required this.xp,
    required this.level,
    required this.streak,
    required this.badges,
    required this.leaderboardRank,
  });
}

class Mentor {
  final String id;
  final String name;
  final String profession;
  final List<String> expertise;
  final String bio;
  final int experience;
  final String availability; // Available | Busy | Offline
  final double rating;
  final int totalSessions;
  final String avatar;
  final String email;

  Mentor({
    required this.id,
    required this.name,
    required this.profession,
    required this.expertise,
    required this.bio,
    required this.experience,
    required this.availability,
    required this.rating,
    required this.totalSessions,
    required this.avatar,
    required this.email,
  });
}

class Career {
  final String id;
  final String name;
  final int confidence;
  final List<String> skills;
  final List<String> subjects;
  final List<String> topColleges;
  final String description;
  final String category;

  Career({
    required this.id,
    required this.name,
    required this.confidence,
    required this.skills,
    required this.subjects,
    required this.topColleges,
    required this.description,
    required this.category,
  });
}

class Badge {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String rarity; // common | rare | epic | legendary
  final bool earned;
  final DateTime? earnedAt;

  Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.rarity,
    required this.earned,
    this.earnedAt,
  });
}

class Game {
  final String id;
  final String name;
  final String description;
  final String category;
  final String difficulty; // Easy | Medium | Hard
  final int xpReward;
  final bool unlocked;
  final bool completed;
  final String icon;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.xpReward,
    required this.unlocked,
    required this.completed,
    required this.icon,
  });
}

// ---------------- MOCK DATA ----------------

final mockStudent = Student(
  id: '1',
  name: 'Alex Kumar',
  age: 16,
  studentClass: '10th',
  interests: ['Technology', 'Science', 'Art'],
  email: 'alex@example.com',
  xp: 2450,
  level: 12,
  streak: 7,
  badges: [],
  leaderboardRank: 23,
);

final mockMentors = [
  Mentor(
    id: '1',
    name: 'Dr. Priya Sharma',
    profession: 'Software Engineer',
    expertise: ['Programming', 'AI/ML', 'Career Guidance'],
    bio:
        'Senior Software Engineer at Google with 8+ years in tech. Passionate about helping students discover their potential.',
    experience: 8,
    availability: 'Available',
    rating: 4.8,
    totalSessions: 156,
    avatar: '👩‍💻',
    email: 'priya@example.com',
  ),
  Mentor(
    id: '2',
    name: 'Prof. Rahul Singh',
    profession: 'Research Scientist',
    expertise: ['Physics', 'Research', 'Academia'],
    bio:
        'Physics Professor at IIT Delhi. Helps students navigate research careers and academic paths.',
    experience: 12,
    availability: 'Busy',
    rating: 4.9,
    totalSessions: 203,
    avatar: '👨‍🔬',
    email: 'rahul@example.com',
  ),
  Mentor(
    id: '3',
    name: 'Maya Patel',
    profession: 'UX Designer',
    expertise: ['Design', 'Creativity', 'Tech'],
    bio:
        'Lead UX Designer at Flipkart. Specializes in design thinking and creative problem-solving.',
    experience: 6,
    availability: 'Available',
    rating: 4.7,
    totalSessions: 98,
    avatar: '🎨',
    email: 'maya@example.com',
  ),
];

final mockCareers = [
  Career(
    id: '1',
    name: 'Software Developer',
    confidence: 92,
    skills: ['Problem Solving', 'Logical Thinking', 'Creativity'],
    subjects: ['Mathematics', 'Computer Science'],
    topColleges: ['IIT Bombay', 'IIT Delhi', 'BITS Pilani'],
    description:
        'Build amazing applications and solve complex problems with code.',
    category: 'Technology',
  ),
  Career(
    id: '2',
    name: 'Data Scientist',
    confidence: 87,
    skills: ['Analytics', 'Statistics', 'Machine Learning'],
    subjects: ['Mathematics', 'Statistics', 'Computer Science'],
    topColleges: ['ISI Kolkata', 'IIT Kharagpur', 'IISc Bangalore'],
    description:
        'Analyze data to extract meaningful insights and drive decisions.',
    category: 'Analytics',
  ),
  Career(
    id: '3',
    name: 'Mechanical Engineer',
    confidence: 78,
    skills: ['Spatial Intelligence', 'Problem Solving', 'Design'],
    subjects: ['Physics', 'Mathematics'],
    topColleges: ['IIT Madras', 'NIT Trichy', 'VNIT Nagpur'],
    description: 'Design and build mechanical systems that power the world.',
    category: 'Engineering',
  ),
];

final mockBadges = [
  Badge(
    id: '1',
    name: 'Explorer',
    description: 'Completed your first career assessment',
    icon: '🔍',
    rarity: 'common',
    earned: true,
    earnedAt: DateTime(2024, 1, 15),
  ),
  Badge(
    id: '2',
    name: 'Problem Solver',
    description: 'Solved 10 logic puzzles',
    icon: '🧩',
    rarity: 'rare',
    earned: true,
    earnedAt: DateTime(2024, 2, 3),
  ),
  Badge(
    id: '3',
    name: 'Creative Thinker',
    description: 'Scored high in creative assessments',
    icon: '🎨',
    rarity: 'epic',
    earned: false,
  ),
  Badge(
    id: '4',
    name: 'Streak Master',
    description: 'Maintained a 30-day streak',
    icon: '🔥',
    rarity: 'legendary',
    earned: false,
  ),
];

final mockGames = [
  Game(
    id: '1',
    name: 'Career Icon Adventure',
    description: 'Discover your interests through interactive scenarios',
    category: 'Interests',
    difficulty: 'Easy',
    xpReward: 50,
    unlocked: true,
    completed: true,
    icon: '🎯',
  ),
  Game(
    id: '2',
    name: 'Logic Puzzle Master',
    description: 'Solve puzzles to test your logical reasoning',
    category: 'Logic',
    difficulty: 'Medium',
    xpReward: 75,
    unlocked: true,
    completed: false,
    icon: '🧩',
  ),
  Game(
    id: '3',
    name: 'Spatial Intelligence Lab',
    description: 'Challenge your spatial thinking abilities',
    category: 'Spatial',
    difficulty: 'Hard',
    xpReward: 100,
    unlocked: true,
    completed: false,
    icon: '🧊',
  ),
  Game(
    id: '4',
    name: 'Leadership Island',
    description: 'Explore leadership scenarios and personality traits',
    category: 'Leadership',
    difficulty: 'Medium',
    xpReward: 80,
    unlocked: true,
    completed: false,
    icon: '👑',
  ),
  Game(
    id: '5',
    name: 'Subject Slider Symphony',
    description: 'Match subjects with your academic strengths',
    category: 'Academics',
    difficulty: 'Easy',
    xpReward: 60,
    unlocked: true,
    completed: true,
    icon: '📚',
  ),
  Game(
    id: '6',
    name: 'Bonus Challenge: Future Vision',
    description: 'Unlock by reaching Level 15',
    category: 'Bonus',
    difficulty: 'Hard',
    xpReward: 150,
    unlocked: false,
    completed: false,
    icon: '🌟',
  ),
];

final mockLeaderboard = [
  {"rank": 1, "name": "Ravi Mehta", "xp": 4250, "avatar": "🏆"},
  {"rank": 2, "name": "Sneha Gupta", "xp": 3890, "avatar": "🥈"},
  {"rank": 3, "name": "Arjun Patel", "xp": 3654, "avatar": "🥉"},
  {"rank": 4, "name": "Priya Joshi", "xp": 3201, "avatar": "⭐"},
  {"rank": 5, "name": "Vikram Singh", "xp": 2998, "avatar": "💎"},
  {
    "rank": 23,
    "name": "Alex Kumar",
    "xp": 2450,
    "avatar": "🎮",
  }, // Current user
  {"rank": 24, "name": "Rohan Das", "xp": 2401, "avatar": "🚀"},
  {"rank": 25, "name": "Kavya Reddy", "xp": 2356, "avatar": "🌟"},
];

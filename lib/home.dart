import 'package:cac2025/routes/appRoutes.dart';
import 'package:flutter/material.dart';

double currentXP = 70;
double maxXP = 100;
String level = 'Grass Roots Gardener';

List<Map<String, dynamic>> plants = [
  {
    'name': 'Rose',
    'nickname': 'Andrew',
    'image': 'assets/rose.png',
    'watering_frequency': 3,
    'last_watered': DateTime(2025, 10, 17),
    'sunlight': 'Full sun (6+ hours)',
    'soil': 'Well-drained, fertile soil',
    'pruning': 'Prune regularly for better blooms',
    'notes': '',
  },
  {
    'name': 'Tulip',
    'nickname': 'Ankith',
    'image': 'assets/tulip.png',
    'watering_frequency': 7,
    'last_watered': DateTime(2025, 10, 13),
    'sunlight': 'Full sun to partial shade',
    'soil': 'Sandy, well-drained',
    'pruning': null,
    'notes': 'Plant bulbs in fall for spring blooms',
  },
  {
    'name': 'Basil',
    'nickname': 'Varad',
    'image': 'assets/basil.png',
    'watering_frequency': 2,
    'last_watered': DateTime(2025, 10, 19),
    'sunlight': 'Full sun (6-8 hours)',
    'soil': 'Rich, moist soil',
    'pruning': 'Harvest leaves to encourage growth',
    'notes': '',
  },
  {
    'name': 'Cactus',
    'nickname': 'Arjun',
    'image': 'assets/cactus.png',
    'watering_frequency': 21,
    'last_watered': DateTime(2025, 10, 1),
    'sunlight': 'Bright, indirect light',
    'soil': 'Cactus mix, very well-drained',
    'pruning': null,
    'notes': 'Avoid overwatering to prevent rot',
  },
  {
    'name': 'Lavender',
    'nickname': 'Ron Weasley',
    'image': 'assets/lavender.png',
    'watering_frequency': 7,
    'last_watered': DateTime(2025, 10, 15),
    'sunlight': 'Full sun',
    'soil': 'Sandy or gravelly, alkaline',
    'pruning': null,
    'notes': 'Good for pollinators and fragrance',
  },
];

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Today();
        break;
      case 1:
        page = MyPlants();
        break;
      case 2:
        page = Community();
        break;
      case 3:
        page = Account();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 40),
              IntrinsicHeight(
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/logo.png'),
                    ),
                    SizedBox(width: 23),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back, GoGarden!',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Today is Monday, October 20th',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          FractionallySizedBox(
                            widthFactor: currentXP / maxXP,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${currentXP.toInt()} / ${maxXP.toInt()} XP',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    level,
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => setState(() => selectedIndex = 0),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          color: selectedIndex == 0 ? Colors.green : Colors.black,
                          decoration: selectedIndex == 0 ? TextDecoration.underline : null,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => setState(() => selectedIndex = 1),
                      child: Text(
                        'My Plants',
                        style: TextStyle(
                          color: selectedIndex == 1 ? Colors.green : Colors.black,
                          decoration: selectedIndex == 1 ? TextDecoration.underline : null,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => setState(() => selectedIndex = 2),
                      child: Text(
                        'Community',
                        style: TextStyle(
                          color: selectedIndex == 2 ? Colors.green : Colors.black,
                          decoration: selectedIndex == 2 ? TextDecoration.underline : null,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => setState(() => selectedIndex = 3),
                      child: Text(
                        'Account',
                        style: TextStyle(
                          color: selectedIndex == 3 ? Colors.green : Colors.black,
                          decoration: selectedIndex == 3 ? TextDecoration.underline : null,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: page),
            ],
          ),

          if (selectedIndex == 1)
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                heroTag: 'addPlantFab',
                onPressed: () async {
                  final result = await Navigator.of(context).pushNamed('/add-plant-screen');
                  if (result is Map<String, dynamic>) {
                    setState(() {
                      plants.add(result);
                    });
                  }
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final Map<String, dynamic> plant;
  const PlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                plant['image'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: Icon(Icons.local_florist, color: Colors.green),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          plant['name'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (plant['nickname']?.isNotEmpty == true)
                        Text(
                          plant['nickname'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                        ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => PlantDetails(plant: plant)),
                    ),
                    child: Text('View Schedule'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlantDetails extends StatelessWidget {
  final Map<String, dynamic> plant;
  const PlantDetails({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plant['name']), backgroundColor: Colors.green[700], foregroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(plant['image']), fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      plant['nickname'] ?? '',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _info(Icons.water_drop, Colors.blue, 'Watering', 'Every ${plant['watering_frequency']} days'),
                  _info(Icons.calendar_today, Colors.green, 'Last Watered', plant['last_watered'].toString().split(' ')[0]),
                  _info(Icons.event, Colors.orange, 'Next Watering', plant['last_watered'].add(Duration(days: plant['watering_frequency'])).toString().split(' ')[0]),
                  if (plant['pruning'] != null) _info(Icons.content_cut, Colors.purple, 'Pruning', plant['pruning']),
                  _info(Icons.wb_sunny, Colors.yellow[700]!, 'Sunlight', plant['sunlight']),
                  _info(Icons.terrain, Colors.brown, 'Soil', plant['soil']),
                  if (plant['notes'].isNotEmpty) _info(Icons.notes, Colors.grey, 'Notes', plant['notes']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(IconData icon, Color color, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[800])),
                SizedBox(height: 4),
                Text(content, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Today extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = DateTime(2025, 10, 20);
    final duePlants = plants.where((p) {
      final daysSince = today.difference(p['last_watered']).inDays;
      return daysSince >= p['watering_frequency'];
    }).toList();

    return Column(
      children: [
        Text('Today', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Expanded(
          child: duePlants.isEmpty
              ? Center(child: Text('No plants need water today!', style: TextStyle(color: Colors.green)))
              : ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: duePlants.length,
            itemBuilder: (_, i) => PlantCard(plant: duePlants[i]),
          ),
        ),
        ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/lock'), child: Text("Return to lock")),
      ],
    );
  }
}

class MyPlants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('My Plants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Expanded(
          child: plants.isEmpty
              ? Center(child: Text('No plants yet. Add one!', style: TextStyle(color: Colors.grey)))
              : ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: plants.length,
            itemBuilder: (_, i) => PlantCard(plant: plants[i]),
          ),
        ),
        ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/lock'), child: Text("Return to lock")),
      ],
    );
  }
}

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _forumController = TextEditingController();
  final List<String> _forumPosts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _forumController.dispose();
    super.dispose();
  }

  void _submitPost() {
    if (_forumController.text.trim().isNotEmpty) {
      setState(() {
        _forumPosts.insert(0, _forumController.text.trim());
        _forumController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.green[50],
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.green[700],
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green[700],
            tabs: [
              Tab(text: 'Leaderboard'),
              Tab(text: 'Goals'),
              Tab(text: 'Forum'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _leaderboardRow('Alice', 1250, 1),
                  _leaderboardRow('Bob', 980, 2),
                  _leaderboardRow('You', currentXP.toInt(), 3),
                  _leaderboardRow('Cara', 720, 4),
                  _leaderboardRow('David', 680, 5),
                ],
              ),
              ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _goalCard('Water 5 plants today', 3, 5),
                  _goalCard('Add 2 new plants this week', 1, 2),
                  _goalCard('Help 3 people in forum', 0, 3),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _forumController,
                            decoration: InputDecoration(
                              hintText: 'Ask a question or share a tip...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _submitPost,
                          child: Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _forumPosts.isEmpty
                        ? Center(child: Text('No posts yet. Be the first!'))
                        : ListView.builder(
                      itemCount: _forumPosts.length,
                      itemBuilder: (context, i) {
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: ListTile(
                            title: Text(_forumPosts[i]),
                            subtitle: Text('Just now'),
                            leading: CircleAvatar(child: Text('U')),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/lock'),
          child: Text("Return to lock"),
        ),
      ],
    );
  }

  Widget _leaderboardRow(String name, int xp, int rank) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: rank == 1 ? Colors.amber : rank == 2 ? Colors.grey : Colors.brown,
        child: Text('$rank', style: TextStyle(color: Colors.white)),
      ),
      title: Text(name, style: TextStyle(fontWeight: name == 'You' ? FontWeight.bold : FontWeight.normal)),
      trailing: Text('$xp XP', style: TextStyle(color: Colors.green[700])),
    );
  }

  Widget _goalCard(String title, int done, int total) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text('$done/$total', style: TextStyle(color: done == total ? Colors.green : Colors.orange)),
      ),
    );
  }
}

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(radius: 60, backgroundImage: AssetImage('assets/logo.png')),
          ),
          SizedBox(height: 16),
          Center(child: Text('GoGarden User', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          Center(child: Text('gardener@gmail.com', style: TextStyle(color: Colors.grey))),
          SizedBox(height: 32),
          _infoRow('Level', level),
          _infoRow('Total XP', '${currentXP.toInt()}/${maxXP.toInt()}'),
          _infoRow('Plants Owned', '${plants.length}'),
          _infoRow('Joined', 'March 2025'),
          _infoRow('Location', 'Illinois, USA'),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => Navigator.pushNamed(context, '/lock'),
              child: Text('Sign Out', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(color: Colors.green[700])),
        ],
      ),
    );
  }
}
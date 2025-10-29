import 'package:flutter/material.dart';

double currentXP = 70;
double maxXP = 100;
String level = 'Grass Roots Gardener';

final List<Map<String, dynamic>> plants = [
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
      body: Column(
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
                      'Not sure what subtext goes here',
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
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
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
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
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
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
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
                  onPressed: () {
                    setState(() {
                      selectedIndex = 3;
                    });
                  },
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
          Expanded(
            child: page,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                    child: Icon(Icons.error),
                  );
                },
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
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        plant['nickname'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => PlantDetails(plant: plant),
                        ),
                      );
                    },
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
      appBar: AppBar(
        title: Text(plant['name']),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(plant['image']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      plant['nickname'] ?? '',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                  _buildInfoSection(
                    icon: Icons.water_drop,
                    color: Colors.blue,
                    title: 'Watering Schedule',
                    content: 'Water every ${plant['watering_frequency']} days',
                  ),
                  _buildInfoSection(
                    icon: Icons.calendar_today,
                    color: Colors.green,
                    title: 'Last Watered',
                    content: plant['last_watered'].toLocal().toString().split(' ')[0],
                  ),
                  _buildInfoSection(
                    icon: Icons.event,
                    color: Colors.orange,
                    title: 'Next Watering',
                    content: plant['last_watered']
                        .add(Duration(days: plant['watering_frequency']))
                        .toLocal()
                        .toString()
                        .split(' ')[0],
                  ),
                  if (plant['pruning'] != null)
                    _buildInfoSection(
                      icon: Icons.content_cut,
                      color: Colors.purple,
                      title: 'Pruning Schedule',
                      content: plant['pruning'],
                    ),
                  _buildInfoSection(
                    icon: Icons.wb_sunny,
                    color: Colors.yellow[700]!,
                    title: 'Sunlight',
                    content: plant['sunlight'],
                  ),
                  _buildInfoSection(
                    icon: Icons.terrain,
                    color: Colors.brown,
                    title: 'Soil',
                    content: plant['soil'],
                  ),
                  if (plant['notes'].isNotEmpty)
                    _buildInfoSection(
                      icon: Icons.notes,
                      color: Colors.grey,
                      title: 'Notes',
                      content: plant['notes'],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required Color color,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(fontSize: 16),
                ),
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
    DateTime currentDate = DateTime(2025, 10, 20);
    var todayPlants = plants.where((plant) {
      int daysSince = currentDate.difference(plant['last_watered']).inDays;
      return daysSince >= plant['watering_frequency'];
    }).toList();

    return Column(
      children: [
        Text(
          'Today',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: todayPlants.length,
            itemBuilder: (context, index) {
              final plant = todayPlants[index];
              return PlantCard(plant: plant);
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/lock');
          },
          child: Text("Return to lock"),
        ),
      ],
    );
  }
}

class MyPlants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'My Plants',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return PlantCard(plant: plant);
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/lock');
          },
          child: Text("Return to lock"),
        ),
      ],
    );
  }
}


class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            'Community'
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/lock');
          },
          child: Text("Return to lock"),
        ),
      ],
    );
  }
}


class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            'Account'
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/lock');
          },
          child: Text("Return to lock"),
        ),
      ],
    );
  }
}

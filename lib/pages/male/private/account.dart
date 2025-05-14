import 'package:flutter/material.dart';

import '../../../shared/botton_nav_bar.dart';

class Account extends StatefulWidget {
  static const String routeName = '/account';

  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Map<String, dynamic> userData = {
    'name': 'Alex',
    'age': 28,
    'location': 'New York',
    'bio': 'Here for a good time not a long time.',
    'profileImage': 'https://randomuser.me/api/portraits/men/32.jpg',
    'preferences': {
      'ageRange': [24, 32],
      'lookingFor': 'Relationship',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.red),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile pressed')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildSectionTitle('About Me'),
            _buildInfoCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  userData['bio'],
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('My Preferences'),
            _buildInfoCard(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPreferenceRow(Icons.face, 'Age Range',
                        '${userData['preferences']['ageRange'][0]}-${userData['preferences']['ageRange'][1]} years'),
                    const Divider(),
                    _buildPreferenceRow(Icons.favorite, 'Looking For',
                        userData['preferences']['lookingFor']),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Account'),
            _buildAccountSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: HookUpNavBar(
        currentIndex: 3,
        onTap: (index) {
          print("Tapped tab: $index");
          // Handle navigation logic here
        },
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(userData['profileImage']),
          ),
          const SizedBox(height: 16),
          Text(
            '${userData['name']}, ${userData['age']}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                userData['location'],
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInfoCard({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: child,
      ),
    );
  }

  Widget _buildPreferenceRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.red),
        const SizedBox(width: 10),
        Text(
          '$title: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(value, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget _buildAccountSection() {
    return _buildInfoCard(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.red),
            title: const Text('Change Password'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change Password tapped')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushNamed(context, "/login");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout tapped')),
              );
            },
          ),
        ],

      ),

    );

  }
}

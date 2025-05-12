import 'package:flutter/material.dart';
import '../../../shared/botton_nav_bar.dart';

class Requests extends StatefulWidget {
  static const String routeName = '/requests';

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final List<Map<String, dynamic>> requests = [
    {
      'name': 'Sarah',
      'duration': '1 Hour Meetup',
      'price': 'R50',
      'hosting': 'I Host',
      'status': 'pending', // Changed from 'waiting' to 'pending'
      'timestamp': '10 min ago',
    },
    {
      'name': 'Jessica',
      'duration': '2 Hour Meetup',
      'price': 'R100',
      'hosting': 'She Hosts',
      'status': 'pending',
      'timestamp': '25 min ago',
    },
    {
      'name': 'Emma',
      'duration': '1.5 Hour Meetup',
      'price': 'R75',
      'hosting': 'I Host',
      'status': 'accepted',
      'timestamp': '2 hours ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sent Requests'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: requests.isEmpty
            ? Center(
          child: Text(
            'No requests sent yet',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
            : ListView.separated(
          itemCount: requests.length,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final request = requests[index];
            return _buildRequestCard(request);
          },
        ),
      ),
      bottomNavigationBar: HookUpNavBar(
        currentIndex: 1,
        onTap: (index) {
          print("Tapped tab: $index");
        },
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  request['timestamp'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Duration', style: TextStyle(color: Colors.grey)),
                      Text('Price', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(request['duration'],
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text(request['price'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hosting', style: TextStyle(color: Colors.grey)),
                      Text('Total', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(request['hosting']),
                      Text('${request['price']}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildStatusSection(request),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection(Map<String, dynamic> request) {
    switch (request['status']) {
      case 'accepted':
        return Column(
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Text(
                  'Accepted',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to chat
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Message'),
              ),
            ),
          ],
        );
      case 'pending':
      default:
        return Column(
          children: [
            Text(
              'Pending response',
              style: TextStyle(color: Colors.orange),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _cancelRequest(request),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey),
                ),
                child: Text(
                  'Cancel Request',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
          ],
        );
    }
  }

  void _cancelRequest(Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cancel Request?'),
        content: Text('This will cancel your request to ${request['name']}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                requests.remove(request);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Request cancelled')),
              );
            },
            child: Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
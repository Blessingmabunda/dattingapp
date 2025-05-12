import 'package:flutter/material.dart';
import '../../../shared/botton_nav_bar.dart';
// import 'professional_nav_bar.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  Offset _offset = Offset.zero;
  String? _swipeFeedback;

  final List<String> names = ['Sarah', 'Emily', 'Olivia'];

  void _nextCard() {
    setState(() {
      currentIndex++;
      _offset = Offset.zero;
      _swipeFeedback = null;
    });
  }

  void _likeProfile() => _nextCard();

  void _dismissProfile() => _nextCard();

  void _handleSwipe(DragUpdateDetails details) {
    setState(() {
      _offset += details.delta;
      if (_offset.dx > 50) {
        _swipeFeedback = 'Liked ❤️';
      } else if (_offset.dx < -50) {
        _swipeFeedback = 'Disliked ❌';
      } else {
        _swipeFeedback = null;
      }
    });
  }

  void _endSwipe(DragEndDetails details) {
    final width = MediaQuery.of(context).size.width;
    if (_offset.dx > width * 0.3) {
      _likeProfile();
    } else if (_offset.dx < -width * 0.3) {
      _dismissProfile();
    } else {
      setState(() {
        _offset = Offset.zero;
        _swipeFeedback = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.person, color: Colors.grey[800], size: 30),
              onPressed: () {
                // Profile action
              },
            ),
            SizedBox(width: 48),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentIndex < names.length) _buildProfileCard(),
            if (currentIndex >= names.length)
              Text(
                'No more profiles',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            SizedBox(height: 30),
            _buildActionButtons(),
          ],
        ),
      ),
      bottomNavigationBar: HookUpNavBar(
        currentIndex: 0,
        onTap: (index) {
          print("Tapped tab: $index");
          // Handle navigation logic here
        },
      ),
    );
  }

  Widget _buildProfileCard() {
    return GestureDetector(
      onPanUpdate: _handleSwipe,
      onPanEnd: _endSwipe,
      child: Transform.translate(
        offset: _offset,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 50, color: Colors.grey[400]),
                      SizedBox(height: 10),
                      Text('Live Camera Feed',
                          style: TextStyle(color: Colors.grey[500])),
                    ],
                  ),
                ),
              ),
              if (_swipeFeedback != null)
                Positioned(
                  top: 40,
                  left: _swipeFeedback == 'Liked ❤️' ? 20 : null,
                  right: _swipeFeedback == 'Disliked ❌' ? 20 : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _swipeFeedback!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        names[currentIndex],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                         Navigator.pushNamed(context, "/viewservice");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: Text(
                          'View Services',
                          style: TextStyle(
                            color: Color(0xFF001F54),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          icon: Icons.close,
          color: Colors.red,
          onPressed: _dismissProfile,
        ),
        SizedBox(width: 30),
        _buildActionButton(
          icon: Icons.favorite,
          color: Colors.green,
          onPressed: _likeProfile,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: Icon(icon, size: 30, color: color),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

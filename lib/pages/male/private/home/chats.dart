import 'package:flutter/material.dart';

import '../../../../shared/botton_nav_bar.dart';

class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final int unreadCount;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.unreadCount = 0,
  });
}

class Chats extends StatefulWidget {
  static const String routeName = '/chats';

  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  // Sample chat data
  final List<ChatModel> chatList = [
    ChatModel(
      name: "John Smith",
      message: "Hey, how are you doing?",
      time: "10:30 AM",
      avatarUrl: "https://randomuser.me/api/portraits/men/1.jpg",
      unreadCount: 3,
    ),
    ChatModel(
      name: "Sarah Johnson",
      message: "Did you see the latest movie?",
      time: "9:45 AM",
      avatarUrl: "https://randomuser.me/api/portraits/women/2.jpg",
      unreadCount: 1,
    ),
    ChatModel(
      name: "Michael Brown",
      message: "Meeting at 2pm today",
      time: "Yesterday",
      avatarUrl: "https://randomuser.me/api/portraits/men/3.jpg",
    ),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          "Chats",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          return _buildChatItem(chatList[index]);
        },
      ),

      bottomNavigationBar: HookUpNavBar(
        currentIndex: 2,
        onTap: (index) {
          print("Tapped tab: $index");
          // Handle navigation logic here
        },
      ),
    );
  }

  Widget _buildChatItem(ChatModel chat) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.red.withOpacity(0.1),
            width: 1.0,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.red.withOpacity(0.2),
          backgroundImage: NetworkImage(chat.avatarUrl),
        ),
        title: Text(
          chat.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            chat.message,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat.time,
              style: TextStyle(
                color: chat.unreadCount > 0 ? Colors.red : Colors.grey[500],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            if (chat.unreadCount > 0)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Text(
                  chat.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, "/chat");
        },
      ),
    );
  }
}

// Main app for testing
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Chats(),
      routes: {
        Chats.routeName: (context) => const Chats(),
      },
    );
  }
}
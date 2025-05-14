import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../shared/botton_nav_bar.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/chat';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [
    Message(text: "Hey, when works?", isMe: false, time: "8:30 PM"),
    Message(text: "How about tomorrow at 5?", isMe: true, time: "8:32 PM"),
  ];
  bool _showArrivedButton = false;
  bool _showDepartedButton = false;
  DateTime? _arrivalTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
              radius: 16,
            ),
            const SizedBox(width: 10),
            const Text("Sarah"),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.call_end, color: Colors.red),
              onPressed: () => _endChat(context),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Pinned request info
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.push_pin, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  "Request: 1 Hour, R50, I Host",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message.isMe
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: message.isMe
                            ? const Radius.circular(12)
                            : const Radius.circular(0),
                        bottomRight: message.isMe
                            ? const Radius.circular(0)
                            : const Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.text,
                          style: TextStyle(
                            color: message.isMe ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message.time,
                          style: TextStyle(
                            color: message.isMe
                                ? Colors.white70
                                : Colors.grey[600],
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Message input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _takePhoto,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (text) {
                      _sendMessage(text);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      _sendMessage(_messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),

          // Arrived/Departed buttons
          if (_showArrivedButton || _showDepartedButton)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[100],
              child: Center(
                child: _showDepartedButton
                    ? Column(
                  children: [
                    Text(
                      "Arrived: ${DateFormat('h:mm a, MMM d, y').format(_arrivalTime!)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _confirmDeparture,
                        child: const Text("Departed Safely"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Payment Held: R50",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _confirmArrival,
                    child: const Text("Arrived Safely"),
                  ),
                ),
              ),
            ),
        ],
      ),
        bottomNavigationBar: HookUpNavBar(
          currentIndex: 2,
          onTap: (index) {
            print("Tapped tab: $index");
            // Handle navigation logic here
          },
        )
    );
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.add(
        Message(text: text, isMe: true, time: DateFormat('h:mm a').format(DateTime.now())),
      );
      _messageController.clear();
    });
  }

  void _takePhoto() {
    // Implement camera functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Take Photo"),
        content: const Text("Camera functionality would be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _confirmArrival() {
    setState(() {
      _showArrivedButton = false;
      _showDepartedButton = true;
      _arrivalTime = DateTime.now();
    });
  }

  void _confirmDeparture() {
    // Implement payment release and meetup logging
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Meetup Complete"),
        content: const Text(
            "Payment of R50 has been released. This meetup has been logged."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _showDepartedButton = false;
              });
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _endChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("End Chat"),
        content: const Text("Are you sure you want to end this chat?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("End Chat", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;
  final String time;

  Message({required this.text, required this.isMe, required this.time});
}
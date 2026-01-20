import 'package:flutter/material.dart';
import 'package:flutter_pirinku/widgets/input_chat_widget.dart';

// Contoh penggunaan InputChatWidget
class InputChatExample extends StatefulWidget {
  const InputChatExample({Key? key}) : super(key: key);

  @override
  State<InputChatExample> createState() => _InputChatExampleState();
}

class _InputChatExampleState extends State<InputChatExample> {
  final TextEditingController _chatController = TextEditingController();
  List<String> messages = [];

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Chat Example')),
      body: Column(
        children: [
          // Display messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(messages[index]),
                  ),
                );
              },
            ),
          ),

          // Input Chat Widget
          Padding(
            padding: const EdgeInsets.all(16),
            child: InputChatWidget(
              controller: _chatController,
              hintText: 'Ada apa di dapur? ketik disini...',
              onCameraPressed: () {
                print('Camera button pressed');
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Camera dibuka')));
              },
              onMicPressed: () {
                print('Mic button pressed');
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Mic aktif')));
              },
              onSendPressed: (message) {
                print('Message sent: $message');
                setState(() {
                  messages.add(message);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pesan terkirim: $message')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

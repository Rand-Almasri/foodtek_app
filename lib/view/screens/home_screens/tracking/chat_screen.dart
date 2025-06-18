import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

import '../../../../core/app_theme/theme_provider.dart';
import '../../../../core/widgets/bottom_navigation_track.dart';
import '../../../../data/models/cart_item.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<CartItem> _cartItems = [];
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender",
    ),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
      messageContent: "Is there any thing wrong?",
      messageType: "sender",
    ),
    ChatMessage(
      messageContent: "yes i have a question about the delivery time",
      messageType: "receiver",
    ),
    ChatMessage(messageContent: "ok i will check", messageType: "sender"),
  ];
  final TextEditingController _controller = TextEditingController();
  void _addToCart(CartItem item) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
              (cartItem) => cartItem.name == item.name && cartItem.restaurant == item.restaurant);

      if (existingIndex >= 0) {
        _cartItems[existingIndex].quantity += 1;
      } else {
        _cartItems.add(item);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(


      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Chat"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Align(
                    alignment:
                    (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:
                        (messages[index].messageType == "receiver"
                            ? Colors.grey.shade200
                            : Colors.green[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 20, top: 10),
            height: 70,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                FloatingActionButton(
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      setState(() {
                        messages.add(
                          ChatMessage(
                            messageContent: _controller.text,
                            messageType: 'sender',
                          ),
                        );
                        _controller.clear();
                      });
                    }
                  },
                  child: Icon(Icons.send, color: Colors.white, size: 18),
                  backgroundColor: Colors.green,
                  elevation: 0,
                ),
              ],
            ),
          ),
        ],
      ),
        bottomNavigationBar: BottomNavigationTrack(
          context: context,
          isDark: themeProvider.isDarkMode,
          cartItems: _cartItems,
          onAddToCart: _addToCart,
        activeIndex: 3,)
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

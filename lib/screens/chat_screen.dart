import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String,dynamic>>messages = [
    {'text':"Hi , Healsync here",
    'isuser':false}
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: messages.length ,
        itemBuilder: (context, index){
          return Container( 
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(16)),
            child: Text(messages[index]['text'],style: TextStyle(color: Colors.white)),);
        }
      )
      );
  }}
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String,dynamic>>messages = [
    {'text':"Hi , Healsync here",
    'isuser':false,},];
  final TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Expanded(child: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: messages.length ,
        itemBuilder: (context, index){
          return Align(alignment: messages[index]['isuser']
          ?Alignment.centerRight
          :Alignment.centerLeft,
          child :Container( 
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(16)),
            child: Text(messages[index]['text'],style: TextStyle(color: Colors.white)),));
        }
      )
       ),
       Container(color: Colors.blue,
       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
       child: Row(
        children: [Expanded(child: TextField(
          controller: _controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(hintText: 'U All Right ?',
          hintStyle: TextStyle(color: Colors.amber),border: InputBorder.none),
        )),IconButton(onPressed: (){
          if(_controller.text.trim().isEmpty)return;
          setState(() {
            messages.add({'text': _controller.text.trim(),
            'isuser':true,});
          });_controller.clear();
        }, icon: Icon(Icons.send,color: Colors.blueAccent,))],
       ),
       )
       ],
       
      ),
      
      
      
      );
  }}
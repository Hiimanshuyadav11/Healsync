import 'package:flutter/material.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String,dynamic>>messages = [
    {'text':"Hi , Healsync here",
    'isUser':false,},];
  final TextEditingController _controller = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: Drawer( 
        backgroundColor: Colors.transparent,
        child:Material(elevation: 10,borderRadius: const BorderRadius.only(
      topRight: Radius.circular(50),
      bottomRight: Radius.circular(50),
        ),
         
        child: Container( decoration: BoxDecoration( gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1F1F1F),
      Color(0xFF2B2B2B),
    ],
  ),
        borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))),
          child: SafeArea(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Container(
              width: double.infinity ,
              padding: const EdgeInsets.all(16),
              
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade900,),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.blueAccent,
                    child: Text('H',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  const SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [const
                    Text('Himanshu', style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold),),
                    Text('Your Wellness Companion 🍀')],
                    
                  )
                ],
              ) 
              ),
              Container(height: 30,),
              
              ListTile(
                leading: const Icon(Icons.person,color: Colors.white,),
                title: const Text('Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white,),
                title: const Text('Settings',
                style: TextStyle(color: Colors.white, 
                fontSize: 18
                ),),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.history,color: Colors.white,),
                title: const Text('History',
                style: TextStyle(color: Colors.white,
                fontSize: 18),),
                onTap: () {},
              ),
              Spacer(),
              ListTile( 
                leading: const Icon(Icons.logout,color: Colors.redAccent,),
                title: Text('LogOut',
                style: TextStyle(color: Colors.white,
                  fontSize: 18
                ),),
                onTap: () {Navigator.pop(context);},
              )
              
            ],
          )),
        ),
      ), ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(230, 64, 26, 26),
        title:  const 
        Text('Healsync'),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: messages.length ,
        itemBuilder: (context, index) {
          return ChatBubble(
            text: messages[index]['text'],
            isUser: messages[index]['isUser'],
            );
            },)),


       Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: const Color.fromARGB(255, 138, 135, 135),),
       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),width: 325,
       child: Row( 
       children: [SizedBox(width: 260, child :TextField( 
          controller: _controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(hintText: 'U All Right ?',
          hintStyle: TextStyle(color: Colors.amber),border: InputBorder.none),))
        ,IconButton(onPressed: (){
          if(_controller.text.trim().isEmpty)return;
         _controller.text.trim();
          setState(() {
            messages.add({'text': _controller.text.trim(),
            'isUser':true,});
          });_controller.clear();
            Future.delayed(Duration(seconds: 1), () {
    setState(() {
      messages.add({
        'text': "I hear you. Want to talk more about it?",
        'isUser': false,
      });
    });
  });
        }, icon: Icon(Icons.send,color: const Color.fromARGB(255, 115, 44, 16),))],
       ),
       )
       
        ]
      ),
      
      
      
      );
  }}
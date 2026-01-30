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
  void _sendmessage() {
    final Text = _controller.text.trim();
    if(Text.isEmpty) return;

    setState(() {
      messages.add({
        'text': Text ,
        'isUser' :true,
      });
    });
    _controller.clear();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add({
          'text':"I hear U want to talk more about it ?",
          'isUser': false,
        });
      });
    } ) ;
  }
 


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
              color: Colors.grey.shade800),
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
        backgroundColor: Color.fromARGB(230, 63, 29, 29),
        title:  const 
        Text('Healsync', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 174, 197, 235)),),
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


      Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
  child: Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 30, 30, 30),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _controller,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => _sendmessage(),
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'U All Right ?',
              border: InputBorder.none,
            )),
        ),),

      const SizedBox(width: 8),
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 115, 44, 16),
        ),
        child: IconButton(
          icon: const Icon(Icons.send, color: Colors.white),
          onPressed: _sendmessage,
        ),),
        ],
  ),)
       
        ]
      ),
      
      
      
      );
  }}
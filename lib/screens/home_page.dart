import 'package:flutter/material.dart';
import 'package:lab33_bastor/screens/dalle_page.dart';
import 'package:lab33_bastor/screens/gemini_page.dart';
import 'package:lab33_bastor/screens/gpt_page.dart';
import 'package:lab33_bastor/screens/pdf_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EMSI ChatBot'),
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu))),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(
              bottom: 165.0), // Adjust the value as needed
          child: Image.asset(
            'assets/images/main_logo.png',
            width: 400.0,
            height: 100.0,
          ),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          const DrawerHeader(
              child: Column(
            children: [
              Text('Menu'),
              CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/avatar_main.png'), // Remplacez par le chemin de votre image
                radius: 50.0, // Vous pouvez ajuster la taille du cercle
              ),
            ],
          )),
          ListTile(
            title: const Text('ChatGPT'),
            leading: const Icon(Icons.access_alarm_rounded),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GptPage()));
            },
          ),
          ListTile(
            title: const Text('PDF AI'),
            leading: const Icon(Icons.access_alarm_rounded),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PdfPage()));
            },
          ),
          ListTile(
            title: const Text('DALL-E'),
            leading: const Icon(Icons.access_alarm_rounded),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DallePage()));
            },
          ),
          ListTile(
            title: const Text('Gemini'),
            leading: const Icon(Icons.access_alarm_rounded),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GeminiPage()));
            },
          ),
          ListTile(
            title: const Text('Meta Seamless'),
            leading: const Icon(Icons.access_alarm_rounded),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const DallePage()));
            },
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

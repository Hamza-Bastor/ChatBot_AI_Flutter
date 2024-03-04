import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  TextEditingController userInputController = TextEditingController();
  List<List<String>> chatHistory = [];

  Future<void> getChatbotResponse(String userInput) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:7777/chatbot/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_input': userInput}),
      );

      if (mounted) {
        // Check if the widget is still in the tree before updating the state
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          setState(() {
            chatHistory = List.from(data['chat_history'] ?? []).map((entry) {
              return [entry[0].toString(), entry[1].toString()];
            }).toList();
          });
        } else {
          print('Failed to load data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (mounted) {
        // Handle error only if the widget is still in the tree
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF AI'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(
              255, 221, 224, 222), // Set your desired background color
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.0,
                  width: 800.0,
                  child: TextField(
                    controller: userInputController,
                    decoration: const InputDecoration(
                      labelText: 'User Input',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 8.0, width: 2.0),
                    const Text(
                      'ChatBot',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Container(
                      height: 300.0,
                      width: 800.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 34, 35, 36)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: chatHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(chatHistory[index][0]),
                            subtitle: Text(chatHistory[index][1]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    String userInput = userInputController.text.trim();
                    if (userInput.isNotEmpty) {
                      await getChatbotResponse(userInput);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userInputController.dispose();
    super.dispose();
  }
}

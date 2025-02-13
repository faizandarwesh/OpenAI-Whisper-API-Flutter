import 'dart:io';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language_translator/recording_screen.dart';
import 'package:language_translator/transcribe_service.dart';
import 'package:path_provider/path_provider.dart';
import 'env/env.dart';

void main() {
  OpenAI.apiKey = Env.apiKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.record_voice_over),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> RecordingScreen()));

        },),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Text(
              'Transcribed Text:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () async{
                    text = await TranscribeService().transcribeFromFile("chinese");
                    setState(() {

                    });
                  },
                  child: const Icon(Icons.looks_one),
                ),
                FloatingActionButton(
                  onPressed: () async{
                    text = await TranscribeService().transcribeFromFile("arabic");
                    setState(() {

                    });
                  },
                  child: const Icon(Icons.looks_two),
                ),
                FloatingActionButton(
                  onPressed: () async{
                    text = await TranscribeService().transcribeFromFile("hindi");
                    setState(() {

                    });
                  },
                  child: const Icon(Icons.looks_3),
                ),
                FloatingActionButton(
                  onPressed: () async{
                    text = await TranscribeService().transcribeFromFile("ehad");
                    setState(() {

                    });
                  },
                  child: const Icon(Icons.looks_4),
                ),
                FloatingActionButton(
                  onPressed: () async{
                    text = await TranscribeService().transcribeFromFile("french");
                    setState(() {

                    });
                  },
                  child: const Icon(Icons.looks_5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

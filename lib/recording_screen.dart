import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:language_translator/transcribe_service.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordingScreen extends StatefulWidget {
  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _filePath;
  String transcribedText = "Please wait!!!";

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();

    if (await Permission.microphone.isGranted) {
      await _recorder.openRecorder(); // Ensure recorder is opened before use
    } else {
      print("Microphone permission denied");
    }
  }

  Future<void> _startRecording() async {
    if (!_recorder.isStopped) return; // Prevent duplicate start

    final tempDir = Directory.systemTemp;
    _filePath = '${tempDir.path}/audio.wav';

    await _recorder.startRecorder(toFile: _filePath);
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    if (_recorder.isRecording) {
      await _recorder.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      print("Recording saved to: $_filePath");
      transcribedText = await TranscribeService().transcribe(_filePath!);
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder(); // Ensure proper cleanup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Record & Transcribe")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(transcribedText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? "Stop Recording" : "Start Recording"),
            ),
          ],
        ),
      ),
    );
  }
}

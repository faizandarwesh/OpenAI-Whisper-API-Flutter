import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class TranscribeService {
  Future<String> transcribeFromFile(String filePath) async {
    // Load the asset (mp3 file) as bytes
    ByteData byteData = await rootBundle.load("assets/audio/$filePath.mp3");

    // Get the temporary directory
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = "${tempDir.path}/audio.mp3";

    // Write the bytes to a temporary file
    File tempFile = File(tempPath);
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());

    OpenAIAudioModel transcription =
        await OpenAI.instance.audio.createTranscription(
      file: tempFile,
      model: "whisper-1",
      responseFormat: OpenAIAudioResponseFormat.json,
    );

// print the transcription.
    print("TRANSCRIBED_TEXT : ${transcription.text}");

    return transcription.text;
  }

  Future<String> transcribe(String filePath) async {
    File tempFile = File(filePath);

    OpenAIAudioModel transcription =
        await OpenAI.instance.audio.createTranscription(
      file: tempFile,
      model: "whisper-1",
      responseFormat: OpenAIAudioResponseFormat.json,
    );

// print the transcription.
    print("TRANSCRIBED_TEXT : ${transcription.text}");

    return transcription.text;
  }
}

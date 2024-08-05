import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_touma_mobile/src/models/document_model.dart';
import 'package:smart_touma_mobile/src/providers/documents_provider.dart';
import 'package:smart_touma_mobile/theme/app_theme.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class EditDocumentScreen extends StatefulWidget {
  final Document document;
  const EditDocumentScreen({super.key, required this.document});

  @override
  State<EditDocumentScreen> createState() => _EditDocumentScreenState();
}

class _EditDocumentScreenState extends State<EditDocumentScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  final TextEditingController _controller = TextEditingController();

  void _saveEdits() async {
    await Provider.of<DocumentsProvider>(context, listen: false)
        .updateDocument(_controller.text, widget.document);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(
        onResult: _onSpeechResult,
        localeId: 'en_US',
        listenFor: const Duration(seconds: 60));
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _controller.text = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Document'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.hPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.document.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'User commands',
                  hintText: 'User commands',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Recognized words:',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    // If listening is active show the recognized words
                    _speechToText.isListening
                        ? _lastWords
                        // If listening isn't active but could be tell the user
                        // how to start it, otherwise indicate that speech
                        // recognition is not yet ready or not supported on
                        // the target device
                        : _speechEnabled
                            ? 'Tap the microphone to start listening...'
                            : 'Speech not available',
                  ),
                ),
              ),
              Consumer<DocumentsProvider>(builder: (context, provider, child) {
                return Column(
                  children: [
                    provider.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _saveEdits,
                            child: const Text('Save'),
                          ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Listen',
        child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      ),
    );
  }
}

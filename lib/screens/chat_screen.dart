import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../utils/app_const.dart';
import '../widgets/chat_text_form_field.dart';
import '../widgets/message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final GenerativeModel _model;
  late final ScrollController _scrollController;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late ChatSession _chatSession;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();

    // setup the model
    _model = GenerativeModel(
      model: geminiModelPro,
      apiKey: apiKey,
    );

    _scrollController = ScrollController();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _isLoading = false;
    // start the chat
    _chatSession = _model.startChat();
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),

        // 채팅 대화록
        child: ListView.builder(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .02,
            bottom: MediaQuery.of(context).size.height * .15,
          ),
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemCount: _chatSession.history.length,
          itemBuilder: (context, index) {
            var content = _chatSession.history.toList()[index];
            final message = _getMessageFromContent(content);

            // 메시지 반환
            return MessageWidget(
              isFromUser: content.role == 'user',
              message: message,
            );
          },
        ),
      ),

      // 메시지 입력창
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            8.0,
          ),
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: Form(
                  key: _formKey,
                  child: ChatTextFormField(
                    controller: _textController,
                    focusNode: _focusNode,
                    isReadOnly: _isLoading,
                    onFieldSubmitted: _sendChatMessage,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              if (!_isLoading) ...[
                ElevatedButton(
                  onPressed: () {
                    _sendChatMessage(_textController.text);
                  },
                  child: const Text('Send'),
                ),
              ] else ...[
                const CircularProgressIndicator.adaptive(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getMessageFromContent(Content content) {
    return content.parts.whereType<TextPart>().map((e) => e.text).join('');
  }

  void _sendChatMessage(String message) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _setLoading(true);
    try {
      final response = await _chatSession.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      if (text == null) {
        _showError('No response was found');
        _setLoading(false);
      } else {
        _setLoading(false);
      }
    } catch (e) {
      _showError(e.toString());
      _setLoading(false);
    } finally {
      _textController.clear();
      _focusNode.requestFocus();
      _setLoading(false);
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          scrollable: true,
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

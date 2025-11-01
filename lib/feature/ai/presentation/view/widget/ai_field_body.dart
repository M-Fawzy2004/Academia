import 'package:flutter/material.dart';
import 'package:study_box/feature/ai/data/model/chat_message_model.dart';
import 'package:study_box/feature/ai/presentation/view/widget/chat_input.dart';
import 'package:study_box/feature/ai/presentation/view/widget/messages_list.dart';

class AiFieldBody extends StatefulWidget {
  const AiFieldBody({super.key});

  @override
  State<AiFieldBody> createState() => _AiFieldBodyState();
}

class _AiFieldBodyState extends State<AiFieldBody> {
  final List<ChatMessageModel> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add(
      ChatMessageModel(
        text: 'مرحباً! كيف يمكنني مساعدتك؟',
        isMe: false,
        time: DateTime.now(),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.insert(
        0,
        ChatMessageModel(
          text: _controller.text,
          isMe: true,
          time: DateTime.now(),
        ),
      );
    });

    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MessagesList(
            messages: _messages,
            scrollController: _scrollController,
          ),
        ),
        ChatInput(controller: _controller, onSend: _sendMessage),
      ],
    );
  }
}


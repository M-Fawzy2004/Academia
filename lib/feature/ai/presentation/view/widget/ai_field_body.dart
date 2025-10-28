// ai_field_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/core/theme/app_radius.dart';
import 'package:study_box/core/theme/styles.dart';

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
          child: _MessagesList(
            messages: _messages,
            scrollController: _scrollController,
          ),
        ),
        ChatInput(
          controller: _controller,
          onSend: _sendMessage,
        ),
      ],
    );
  }
}

// ==================== Messages List ====================
class _MessagesList extends StatelessWidget {
  const _MessagesList({
    required this.messages,
    required this.scrollController,
  });

  final List<ChatMessageModel> messages;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const _EmptyState();
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatBubble(message: messages[index]);
      },
    );
  }
}

// ==================== Empty State ====================
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 80.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'ابدأ محادثتك',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== Chat Message Model ====================
// chat_message_model.dart
class ChatMessageModel {
  final String text;
  final bool isMe;
  final DateTime time;

  ChatMessageModel({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

// ==================== Chat Bubble ====================
// chat_bubble.dart
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isMe) _buildAvatar(),
          if (!message.isMe) SizedBox(width: 8.w),
          _buildMessageContainer(context),
          if (message.isMe) SizedBox(width: 8.w),
          if (message.isMe) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: message.isMe
          ? AppColors.primaryColor
          : AppColors.primaryColor.withOpacity(0.2),
      child: Icon(
        message.isMe ? Icons.person : Icons.smart_toy_outlined,
        size: 18.sp,
        color: message.isMe ? Colors.white : AppColors.primaryColor,
      ),
    );
  }

  Widget _buildMessageContainer(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: message.isMe
              ? AppColors.primaryColor
              : AppColors.getCardColorTwo(context),
          borderRadius: BorderRadius.circular(AppRadius.small).copyWith(
            topLeft: message.isMe ? null : Radius.circular(4.r),
            topRight: message.isMe ? Radius.circular(4.r) : null,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontSize: 14.sp,
                color: message.isMe
                    ? Colors.white
                    : AppColors.getTextPrimaryColor(context),
                height: 1.4,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _formatTime(message.time),
              style: TextStyle(
                fontSize: 10.sp,
                color: message.isMe
                    ? Colors.white.withOpacity(0.7)
                    : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

// ==================== Chat Input ====================
// chat_input.dart
class ChatInput extends StatelessWidget {
  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'What do you want to ask?',
                hintStyle: Styles.font13GreyBold(context),
                filled: true,
                fillColor: AppColors.getCardColorTwo(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 12.h,
                ),
              ),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.getTextPrimaryColor(context),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
            ),
          ),
          SizedBox(width: 8.w),
          _SendButton(onPressed: onSend),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.send_rounded,
          color: Colors.white,
          size: 18.sp,
        ),
      ),
    );
  }
}

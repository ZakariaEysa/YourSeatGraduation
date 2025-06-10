import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/chat_message_model.dart';
import '../../data/services/chatbot_service.dart';
import '../widgets/chat_ask.dart';
import '../widgets/chat_message_item.dart';
import '../widgets/chat_up.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<ChatMessage> _messages = [];
  final ChatbotService _chatbotService = ChatbotService();
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Add welcome message after context is available
    if (_messages.isEmpty) {
      final locale = Localizations.localeOf(context).languageCode;
      final welcomeMessage = locale == 'ar'
          ? 'مرحباً! يمكنني اقتراح أفلام بناءً على تفضيلاتك. ما نوع الأفلام التي تفضلها؟'
          : 'Hello! I can recommend movies based on your preferences. What kind of movies do you like?';

      _messages.add(
        ChatMessage(
          message: welcomeMessage,
          type: MessageType.bot,
        ),
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Add user message
    setState(() {
      _messages.add(
        ChatMessage(
          message: text,
          type: MessageType.user,
        ),
      );
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      // Get bot response
      //AppLogs.debugLog('Sending message to API: $text');
      final botResponse = await _chatbotService.getRecommendations(text);

      setState(() {
        _messages.add(botResponse);
        _isLoading = false;
      });

      _scrollToBottom();
    } catch (e) {
      //AppLogs.errorLog('Error in chatbot communication: $e');
      final locale = Localizations.localeOf(context).languageCode;
      final errorMessage = locale == 'ar'
          ? 'عذراً، حدثت مشكلة في الاتصال. يرجى المحاولة مرة أخرى لاحقاً.'
          : 'Sorry, I encountered an error. Please try again later.';

      setState(() {
        _messages.add(
          ChatMessage(
            message: errorMessage,
            type: MessageType.bot,
          ),
        );
        _isLoading = false;
      });

      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final emptyListText =
        locale == 'ar' ? 'ابدأ محادثة!' : 'Start a conversation!';
    final isRTL = locale == 'ar';

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: 500.w,
          height: 900.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(-0.00, -1.00),
              end: const Alignment(0, 1),
              colors: [theme.primaryColor, theme.colorScheme.secondary],
            ),
          ),
          child: Column(
            children: [
              const ChatUp(),
              Expanded(
                child: Directionality(
                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                  child: _messages.isEmpty
                      ? Center(
                          child: Text(
                            emptyListText,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          itemCount: _messages.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _messages.length) {
                              return Padding(
                                padding: EdgeInsets.all(16.r),
                                child: Center(
                                  child: SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.w,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return ChatMessageItem(message: _messages[index]);
                          },
                        ),
                ),
              ),
              ChatAsk(onSendMessage: _sendMessage),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

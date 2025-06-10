import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';

class ChatAsk extends StatefulWidget {
  final Function(String) onSendMessage;

  const ChatAsk({
    super.key,
    required this.onSendMessage,
  });

  @override
  _ChatAskState createState() => _ChatAskState();
}

class _ChatAskState extends State<ChatAsk> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double textFieldWidth = 0;

  @override
  Widget build(BuildContext context) {
    var lang = S.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              textFieldWidth =
                  constraints.maxWidth * 0.6; // 70% من عرض الـ TextField
              return Container(
                color: const Color(0xFF27125B),
                width: 390.w,
                height: 95.h,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 8, bottom: 16, left: 16, top: 16),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: const Alignment(1.1, 0.8),
                            children: [
                              TextField(
                                expands: true,
                                controller: _controller,
                                focusNode: _focusNode,
                                maxLines: null, // يسمح بالتعدد التلقائي للأسطر
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF27125B),
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: lang.askmehere,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0XFF6C6363),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onChanged: (text) {
                                  _handleTextChange();
                                },
                              ),
                              Image.asset(
                                'assets/images/img_1.png',
                                width: 40.w,
                                height: 70.h,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _sendMessage,
                          child: Image.asset(
                            'assets/icons/send.png',
                            width: 48.w,
                            height: 55.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSendMessage(_controller.text.trim());
      _controller.clear();
    }
  }

  void _handleTextChange() {
    String text = _controller.text;
    List<String> lines = text.split('\n'); // تقسيم النص إلى أسطر
    String lastLine = lines.isNotEmpty ? lines.last : '';

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: lastLine,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: textFieldWidth);

    if (textPainter.width >= textFieldWidth) {
      _controller.text += '\n'; // يجبر النص على الانتقال لسطر جديد
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

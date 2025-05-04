import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class CustomInput extends StatefulWidget {
  final bool isResponsePending;
  final void Function(types.PartialText) onSendPressed;
  final VoidCallback onCancelPressed;
  final VoidCallback onFilePressed;

  const CustomInput({
    super.key,
    required this.isResponsePending,
    required this.onSendPressed,
    required this.onCancelPressed,
    required this.onFilePressed,
  });

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendPressed(types.PartialText(text: text));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: widget.onFilePressed,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Type a message'),
            ),
          ),
          IconButton(
            icon: Icon(
              widget.isResponsePending
                  ? Icons.cancel_schedule_send
                  : Icons.send,
            ),
            onPressed:
                widget.isResponsePending ? widget.onCancelPressed : _handleSend,
          ),
        ],
      ),
    );
  }
}

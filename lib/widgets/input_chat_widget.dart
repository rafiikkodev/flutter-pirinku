import 'package:flutter/material.dart';
import 'package:flutter_pirinku/app/core/theme/app_theme.dart';

class InputChatWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onCameraPressed;
  final VoidCallback? onMicPressed;
  final Function(String)? onSendPressed;

  const InputChatWidget({
    Key? key,
    this.controller,
    this.hintText = 'Ada apa di dapur? ketik disini...',
    this.onCameraPressed,
    this.onMicPressed,
    this.onSendPressed,
  }) : super(key: key);

  @override
  State<InputChatWidget> createState() => _InputChatWidgetState();
}

class _InputChatWidgetState extends State<InputChatWidget> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _handleSend() {
    if (_controller.text.isNotEmpty) {
      widget.onSendPressed?.call(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Camera Button
          _buildCircularButton(
            onPressed: widget.onCameraPressed,
            icon: Icons.camera_alt,
          ),
          const SizedBox(width: 5),

          // Input Field with Send Button
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: ShapeDecoration(
                color: primaryGreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(500),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(
                        color: txtWhite,
                        fontSize: 12,
                        fontFamily: 'Visby Round CF',
                        fontWeight: medium,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          color: txtWhite.withOpacity(0.8),
                          fontSize: 12,
                          fontFamily: 'Visby Round CF',
                          fontWeight: medium,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send Button
                  GestureDetector(
                    onTap: _hasText ? _handleSend : null,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: _hasText ? txtWhite : txtWhite.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Icon(
                        Icons.send,
                        size: 16,
                        color: _hasText
                            ? primaryGreenColor
                            : primaryGreenColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),

          // Mic Button
          _buildCircularButton(onPressed: widget.onMicPressed, icon: Icons.mic),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required VoidCallback? onPressed,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: ShapeDecoration(
          color: primaryGreenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Icon(icon, color: txtWhite, size: 24),
      ),
    );
  }
}

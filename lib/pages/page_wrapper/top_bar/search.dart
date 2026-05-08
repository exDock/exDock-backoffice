// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/styling.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.width});

  final double width;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _isHoveredOrFocused = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isHoveredOrFocused = _focusNode.hasFocus || _controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHoveredOrFocused = true),
      onExit: (_) => setState(() => _isHoveredOrFocused =
          _focusNode.hasFocus || _controller.text.isNotEmpty),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: widget.width,
        height: 56,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHoveredOrFocused
              ? kBoxShadowList
              : [], // Fades the shadow smoothly
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

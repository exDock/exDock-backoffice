// Dart imports:

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/globals/variables.dart';
import 'package:exdock_backoffice/utils/HTTP/connect_websocket_stream.dart';
import 'package:exdock_backoffice/utils/authentication/authentication_data.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isExpanded = false; // To track whether the list is expanded
  final List<String> _notifications = [];

  OverlayEntry? _overlayEntry;
  ValueNotifier<List<String>>? _notificationsNotifier;

  late Widget notificationIcon = Icon(
    Symbols.notifications_rounded,
    color: Theme.of(context).primaryColor,
  );

  @override
  void initState() {
    super.initState();
    _notificationsNotifier = ValueNotifier<List<String>>(_notifications);

    try {
      final String baseUrl = settings.getSetting("base_url");
      final Uri uri = Uri.parse("$baseUrl/api/v1/ws/error");
      getWebsocketChannel(uri.convertToWs(), _notificationsNotifier!);
    } catch (e) {
      if (e is NotAuthenticatedException) {
        throw NotAuthenticatedException("");
      }
      // if (e is Exception) {
      //   router.push("/login");
      // }
      // throw Exception("Error parsing URI: $e");
    }
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _notificationsNotifier?.dispose();
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        // 8 below the notification bar
        top: position.dy + renderBox.size.height + 8,
        left: position.dx,
        width: renderBox.size.width,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 200, // Fixed height for the expandable section
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ValueListenableBuilder<List<String>>(
                valueListenable: _notificationsNotifier!,
                builder: (context, value, child) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(value[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleOverlay() {
    setState(() {
      if (isExpanded) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      } else {
        // Create the overlay dynamically
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry!);
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: ValueListenableBuilder(
        valueListenable: _notificationsNotifier!,
        builder: (context, value, child) => GestureDetector(
          onTap: () {
            if (value.isNotEmpty) {
              _toggleOverlay();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: kBoxShadowList,
            ),
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (value.isEmpty)
                  notificationIcon
                else
                  Badge(
                      label: Text("${value.length}"), child: notificationIcon),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      value.isEmpty ? "No unread notifications" : value.first,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                if (value.isNotEmpty)
                  Icon(
                    isExpanded
                        ? Symbols.keyboard_arrow_up_rounded
                        : Symbols.keyboard_arrow_down_rounded,
                    color: Colors.black,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

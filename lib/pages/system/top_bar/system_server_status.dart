// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';
import 'package:exdock_backoffice/utils/HTTP/connect_websocket_stream.dart';
import 'package:exdock_backoffice/utils/authentication/authentication_data.dart';
import 'package:exdock_backoffice/widgets/exdock_gradient_progress_bar.dart';

class SystemServerStatus extends StatefulWidget {
  const SystemServerStatus({super.key});

  @override
  State<SystemServerStatus> createState() => _SystemServerStatusState();
}

class _SystemServerStatusState extends State<SystemServerStatus> {
  final ValueNotifier<ServerHealth> _serverHealthNotifier =
      ValueNotifier<ServerHealth>(
    ServerHealth(
      serverStatus: ServerStatus.up,
      timestamp: 0,
      processCpuUsage: 0.0,
      systemCpuUsage: 0.0,
      totalMemory: 0,
      usedMemory: 0,
    ),
  );
  late Future<WebSocketChannel> _channel;

  @override
  void initState() {
    try {
      final String baseUrl = settings.getSetting("base_url");
      final Uri uri = Uri.parse("$baseUrl/api/v1/docker/getData");
      _channel = getWebsocketChannel(uri.convertToWs(), _serverHealthNotifier);
    } catch (e) {
      if (e is NotAuthenticatedException) {
        throw NotAuthenticatedException("");
      }
      throw Exception("Error parsing URI: $e");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("##.###", "en_US");
    return ValueListenableBuilder(
      valueListenable: _serverHealthNotifier,
      builder: (context, ServerHealth serverHealth, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            // Determine if the process CPU usage should
            // be included based on screen width
            final bool includeProcess =
                MediaQuery.of(context).size.width > 1525;
            final List<Widget> processWidgets = includeProcess
                ? [
                    const Text(
                      'Process CPU Usage: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: ExDockGradientProgressBar(
                        progress: serverHealth.processCpuUsage,
                        gradientColors: const [
                          Colors.green,
                          Colors.yellow,
                          Colors.red,
                        ],
                        showPercentage: true,
                      ),
                    ),
                    const SizedBox(width: 24),
                  ]
                : [];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    serverHealth.serverStatus.icon,
                    color: serverHealth.serverStatus.color,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "SERVER STATUS: ${serverHealth.serverStatus.toString().split('.').last.toUpperCase()}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 24),
                  ...processWidgets,
                  const Text(
                    'System CPU Usage: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ExDockGradientProgressBar(
                      progress: serverHealth.systemCpuUsage,
                      gradientColors: const [
                        Colors.green,
                        Colors.yellow,
                        Colors.red,
                      ],
                      showPercentage: true,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    "Memory Usage: ${f.format(serverHealth.usedMemory / 1000)} / "
                    "${f.format(serverHealth.totalMemory / 1000)} GB",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _serverHealthNotifier.dispose();
    _channel.then((channel) => channel.sink.close());
    super.dispose();
  }
}

class ServerHealth {
  final ServerStatus serverStatus;
  final int timestamp;
  final double processCpuUsage;
  final double systemCpuUsage;
  final int totalMemory;
  final int usedMemory;

  ServerHealth({
    required this.serverStatus,
    required this.timestamp,
    required this.processCpuUsage,
    required this.systemCpuUsage,
    required this.totalMemory,
    required this.usedMemory,
  });
}

enum ServerStatus {
  up(color: Colors.green, icon: Icons.check_circle),
  down(color: Colors.red, icon: Icons.error),
  maintenance(
    color: Colors.orange,
    icon: Icons.build,
  ),
  restarting(
    color: Colors.blue,
    icon: Icons.autorenew,
  );

  final Color color;
  final IconData icon;

  const ServerStatus({required this.color, required this.icon});
}

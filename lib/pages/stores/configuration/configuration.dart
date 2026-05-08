// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:exdock_backoffice/pages/stores/configuration/configuration_retrieve_menu.dart';
import 'package:exdock_backoffice/pages/stores/configuration/configuration_side_bar.dart';
import 'package:exdock_backoffice/pages/stores/configuration/content/configuration_content.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key, this.configurationDataKey});

  final String? configurationDataKey;

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  String? configKey;

  void switchToConfigurationsSettingsPage(String configurationDataKey) {
    SystemNavigator.routeInformationUpdated(
      uri: Uri(path: '/stores/configuration/$configurationDataKey'),
    );

    setState(() {
      configKey = configurationDataKey;
    });
  }

  @override
  void initState() {
    super.initState();

    configKey = widget.configurationDataKey;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConfigurationSidebar(
          menuItems: getConfigurationMenu(switchToConfigurationsSettingsPage),
        ),
        Expanded(
          child: ConfigurationContent(configurationDataKey: configKey),
        ),
      ],
    );
  }
}

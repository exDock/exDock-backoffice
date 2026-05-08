// Project imports:
import 'package:exdock_backoffice/pages/stores/configuration/configuration_menu_sub_type.dart';

Map<String, List<ConfigurationMenuSubType>> getConfigurationMenu(
  Function(String) switchToConfigurationsSettingsPage,
) {
  return {
    'general': [],
    'catalog': [],
    'customers': [],
    'sales': [
      ConfigurationMenuSubType(
        title: 'orders',
        onPressed: () {
          switchToConfigurationsSettingsPage('sales/orders');
        },
      ),
      ConfigurationMenuSubType(
        title: 'shipments',
        onPressed: () {
          switchToConfigurationsSettingsPage('sales/shipments');
        },
      ),
      ConfigurationMenuSubType(
        title: 'tax',
        onPressed: () {
          switchToConfigurationsSettingsPage('sales/tax');
        },
      ),
      ConfigurationMenuSubType(
        title: 'checkout',
        onPressed: () {
          switchToConfigurationsSettingsPage('sales/checkout');
        },
      ),
      ConfigurationMenuSubType(
        title: 'payments',
        onPressed: () {
          switchToConfigurationsSettingsPage('sales/payments');
        },
      ),
    ],
    'services': [],
  };
}

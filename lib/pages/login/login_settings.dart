// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_button.dart';
import 'package:exdock_backoffice/widgets/input/exdock_text_field.dart';
import 'package:exdock_backoffice/widgets/popup/exdock_big_popup.dart';

class LoginSettings extends StatefulWidget {
  const LoginSettings({super.key});

  @override
  State<LoginSettings> createState() => _LoginSettingsState();
}

class _LoginSettingsState extends State<LoginSettings> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
    final ValueNotifier<bool> isValidated = ValueNotifier<bool>(false);
    controller.text = settings.getSetting<String>("base_url");

    void handleCheckValues() async {
      try {
        final String base = controller.text;
        final Uri uri = Uri.parse("$base/api/v1/ping");
        if (uri.scheme.isEmpty || uri.host.isEmpty) {
          throw const FormatException("Invalid URL format");
        }

        final response = await get(uri);

        if (response.statusCode != 200) {
          throw Exception("Server not reachable");
        }
        errorNotifier.value = null;
        isValidated.value = true;
      } catch (e) {
        if (e is FormatException) {
          errorNotifier.value = "Invalid URL format";
        } else {
          errorNotifier.value = "Server not reachable";
        }
        isValidated.value = false;
        return;
      }
    }

    void saveSettings() {
      settings.setSetting("base_url", controller.text);
      Navigator.pop(context);
    }

    return IconButton(
      icon: const Icon(Icons.settings),
      tooltip: 'Login Settings',
      onPressed: () {
        showPopupWindow(
          context,
          childFun: (pop) {
            return ExdockBigPopup(
              key: GlobalKey(),
              pop: pop,
              title: "Login Settings",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      ValueListenableBuilder(
                        valueListenable: errorNotifier,
                        builder: (context, errorText, child) {
                          return ExdockTextField(
                            controller: controller,
                            onChanged: (text) {},
                            labelText: "Server URL",
                            errorText: errorText,
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ExdockButton(
                          label: "Check values",
                          onPressed: handleCheckValues,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: isValidated,
                        builder: (context, isValidated, child) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: isValidated
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: ExdockButton(
                                      label: "Save",
                                      onPressed: saveSettings,
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withValues(
                                          alpha: 150,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Please check the server URL",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.red),
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

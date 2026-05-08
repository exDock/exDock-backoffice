// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/pages/login/login_settings.dart';
import 'package:exdock_backoffice/router/router.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/HTTP/login_requests.dart';
import 'package:exdock_backoffice/utils/snackbar/exdock_snackbar.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_button.dart';
import 'package:exdock_backoffice/widgets/input/exdock_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<String> getWebsiteName() async {
    // TODO: retrieve website name
    return "website name";
  }

  Future<int> loginServer(String email, String password) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final HttpData httpGetData = await loginRequest(
      email,
      password,
    );

    return httpGetData.statusCode;
  }

  void loginButtonFunction() async {
    final int statusCode = await loginServer(
      emailController.text,
      passwordController.text,
    );
    if (statusCode == 200) {
      if (mounted) {
        if (context.canPop()) {
          context.pop();
          return;
        }

        if (router.canPop()) {
          router.pop();
        } else {
          router.go("/");
        }
      }
    } else if (statusCode == 401) {
      if (mounted) {
        showExDockSnackBar(
          context: context,
          child:
              const Text("401 has been thrown | user does not have permission"),
        );
      }
    } else if (statusCode == 403) {
      if (mounted) {
        showExDockSnackBar(
          context: context,
          child: const Text("403 has been thrown | invalid credentials"),
        );
      }
    } else if (statusCode == 404) {
      if (mounted) {
        showExDockSnackBar(
          context: context,
          child: const Text("404 has been thrown | server not found"),
        );
      }
    } else if (statusCode == 500) {
      if (mounted) {
        showExDockSnackBar(
          context: context,
          child:
              const Text("500 has been thrown | server experienced an error"),
        );
      }
    } else if (statusCode == 503) {
      if (mounted) {
        showExDockSnackBar(
          context: context,
          child: const Text("503 has been thrown | connection error"),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: LoginSettings(),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 80,
            child: Center(
              child: Container(
                width: 450,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: kBoxShadowList,
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("exDock login"),
                    Text(
                      "website name",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 24),
                    ExdockTextField(
                      controller: emailController,
                      onChanged: (value) {
                        //
                      },
                      labelText: "Email",
                    ),
                    const SizedBox(height: 12),
                    ExdockTextField(
                      isPassword: true,
                      controller: passwordController,
                      onChanged: (value) {
                        //
                      },
                      labelText: "Password",
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ExdockButton(
                            label: "FORGOT PASSWORD",
                            onPressed: () {
                              // TODO: navigate to forgot password page
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ExdockButton(
                            label: "LOGIN",
                            onPressed: loginButtonFunction,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final titleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  bool isLoading = false;
  bool isError = false;
  bool isSuccess = false;

  final mdpController = TextEditingController();
  final loginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                        color: Colors.black,
                        height: 300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Identifiant', style: titleStyle),
                            TextField(
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Mail ou identifiant',
                              ),
                              onChanged: (value) {
                                if (isError || isSuccess) {
                                  setState(() {
                                    isSuccess = false;
                                    isError = false;
                                  });
                                }
                              },
                              controller: loginController,
                            ),
                            const SizedBox(height: 24),
                            Text('Mot de passe', style: titleStyle),
                            TextField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Mail ou identifiant',
                              ),
                              onChanged: (value) {
                                if (isError || isSuccess) {
                                  setState(() {
                                    isSuccess = false;
                                    isError = false;
                                  });
                                }
                              },
                              controller: mdpController,
                            ),
                            const SizedBox(height: 10),
                            if (isSuccess) ...[
                              const SizedBox(height: 10),
                              const Center(
                                  child: Text(
                                'Bravo ! Vous êtes connectés !',
                                style: TextStyle(color: Colors.green),
                              )),
                            ],
                            if (isError) ...[
                              const SizedBox(height: 10),
                              const Center(
                                  child: Text(
                                    'Mauvais login / mot de passe',
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Material(
                                  color: Colors.blueAccent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isLoading = true;
                                        isSuccess = false;
                                        isError = false;
                                      });
                                      FocusScope.of(context).unfocus();
                                      Future.delayed(const Duration(seconds: 2)).then((value) {
                                        if (mdpController.text == 'yoloyolo' && loginController.text == 'remileboss') {
                                          setState(() {
                                            isLoading = false;
                                            isError = false;
                                            isSuccess = true;
                                          });
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                            isError = true;
                                            isSuccess = false;
                                          });
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: isLoading
                                              ? const SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child: CircularProgressIndicator(color: Colors.white),
                                                )
                                              : const Text(
                                                  'Se connecter',
                                                  style:
                                                      TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                                )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(child: Container()),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

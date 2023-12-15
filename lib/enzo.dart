import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EnzoAuraitDuFaireCaPage extends StatefulWidget {
  @override
  State<EnzoAuraitDuFaireCaPage> createState() => _EnzoAuraitDuFaireCaPageState();
}

class _EnzoAuraitDuFaireCaPageState extends State<EnzoAuraitDuFaireCaPage> {
  final titleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  late RiveAnimationController successAnimation;
  late RiveAnimationController failAnimation;
  late StateMachineController _stateController;
  bool isLoading = false;
  bool isError = false;
  bool isSuccess = false;
  late SMIInput<bool> handsUpController;
  late SMIInput<bool> failController;
  late SMIInput<bool> successController;
  late SMIInput<double> oeilController;
  late SMIInput<bool> checkingController;

  final mdpController = TextEditingController();
  final loginController = TextEditingController();
  FocusNode _focus = FocusNode();
  FocusNode _focusLogin = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _focusLogin.addListener(_onFocusChangeLogin);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focusLogin.removeListener(_onFocusChangeLogin);
    _focus.dispose();
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      handsUpController.value = true;
    } else {
      handsUpController.value = false;
    }
  }

  void _onFocusChangeLogin() {
    if (_focusLogin.hasFocus) {
      print('bonjour bonjour');
      checkingController.value = true;
    } else {
      print('aurevoir aurevoir');
      checkingController.value = false;
    }
  }

  void _onInit(Artboard art) {
    var ctrl = StateMachineController.fromArtboard(art, 'Login Machine') as StateMachineController;
    ctrl.isActive = false;
    art.addController(ctrl);
    setState(() {
      _stateController = ctrl;
    });
    handsUpController = _stateController.findInput<bool>('isHandsUp')!;
    failController = _stateController.findInput<bool>('trigFail')!;
    successController = _stateController.findInput<bool>('trigSuccess')!;
    oeilController = _stateController.findInput<double>('numLook')!;
    checkingController = _stateController.findInput<bool>('isChecking')!;
    failController.value = true;
    successController.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E2EA),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              color: Colors.black,
              height: 300,
              child: RiveAnimation.asset(
                'assets/teddy.riv',
                onInit: _onInit,
                fit: BoxFit.fitHeight,
                animations: const [
                  'idle'
                ], //, 'Hands_up', 'hands_down', 'success', 'fail', 'Look_down_right', 'Look_down_left', 'look_idle'],
                //controllers: [successAnimation, failAnimation],
              ),
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
                    focusNode: _focusLogin,
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
                      oeilController.value = value.length * 5;
                    },
                    controller: loginController,
                  ),
                  const SizedBox(height: 24),
                  Text('Mot de passe', style: titleStyle),
                  TextField(
                    focusNode: _focus,
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
                            failController.value = false;
                            successController.value = false;
                            Future.delayed(const Duration(seconds: 2)).then((value) {
                              if (mdpController.text == 'yoloyolo' && loginController.text == 'remileboss') {
                                successController.value = true;
                                setState(() {
                                  isLoading = false;
                                  isError = false;
                                  isSuccess = true;
                                });
                              } else {
                                failController.value = true;
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
        ],
      ),
    );
  }
}

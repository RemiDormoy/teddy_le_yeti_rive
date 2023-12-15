import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EnzoAuraitDuFaireCaPage extends StatefulWidget {
  @override
  State<EnzoAuraitDuFaireCaPage> createState() => _EnzoAuraitDuFaireCaPageState();
}

class _EnzoAuraitDuFaireCaPageState extends State<EnzoAuraitDuFaireCaPage> {
  final titleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  late RiveAnimationController handsDownAnimation;
  late RiveAnimationController handsUpAnimation;
  late StateMachineController _stateController;
  bool handsUp = false;
  late SMIInput<bool> handsUpController;

  final mdpController = TextEditingController();
  final loginController = TextEditingController();
  FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    if (_focus.hasFocus) {
      handsUpController.value = true;
    } else {
      handsUpController.value = false;
    }
    handsUp = !handsUp;
  }

  void _onInit(Artboard art) {
    print('onInit has been called');
    var ctrl = StateMachineController.fromArtboard(art, 'Login Machine') as StateMachineController;
    ctrl.isActive = false;
    art.addController(ctrl);
    setState(() {
      _stateController = ctrl;
    });
    handsUpController = _stateController.findInput<bool>('isHandsUp')!;
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
                //controllers: [handsDownAnimation, handsUpAnimation],
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
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Mail ou identifiant',
                    ),
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
                    controller: mdpController,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Material(
                        color: Colors.blueAccent,
                        child: InkWell(
                          onTap: () {
                            //handsUpController.value = false;
                            FocusScope.of(context).unfocus();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              'Se connecter',
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
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

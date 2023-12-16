import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/components/validators/text/textValidators.dart';
import 'package:project_i_am_in_control/functionalities/userAccount/functions/signIn.dart';
import 'package:project_i_am_in_control/functionalities/userAccount/dialogs/forgotPasswordDialog.dart';
import '../../homePage/screens/homeScreen.dart';

import '../../../components/widgets/form/textInput/textInput.dart';
import 'registerDialog.dart';

Future<void> openLoginDialog(context, [bool barrierDismissible = false]) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: "",
    transitionBuilder: (buidContext, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: LoginDialog(buidContext),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (buidContext, a1, a2) {
      return LoginDialog(buidContext);
    },
  );
}

class LoginDialog extends StatefulWidget {
  const LoginDialog(BuildContext buidContext, {Key? key}) : super(key: key);

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: ()  async => false,
      child: Align(
        alignment: Alignment.center,
        child: StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            content: Container(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.003),
                    const Icon(PhosphorIcons.yinYangFill,
                        size: 60, color: Colors.black),
                    const Text('I am in Control', //traducao
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            fontFamily: 'lato')),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.040),
                    const Text('Bem vindo(a) de volta!', //traducao
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                    TextFormInput(
                      controller: _emailController,
                      validator: (value) => requiredValidator(value, this.context),
                      color: Colors.grey[100],
                      widthByTotal: 0.70,
                      placeholder: 'Email', //traducao
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                    TextFormInput(
                      controller: _passwordController,
                      validator: (value) => requiredValidator(value, this.context),
                      color: Colors.grey[100],
                      widthByTotal: 0.70,
                      placeholder: 'Password', //traducao
                      isPassword: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              openForgotPasswordDialog(context);
                            },
                            child: const Text('Esqueci-me da password', //traducao
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                    fontSize: 10.5)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.050),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseSignIn(context, _emailController.text,
                              _passwordController.text, HomeScreen());
                        }
                      },
                      child: Container(
                        width: (MediaQuery.of(context).size.width * 0.60),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Login',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'lato',
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              )),
                        )),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Text('Ainda não é membro? ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(); 
                            openRegisterDialog(context);
                          },
                          child: Text('Registe-se Aqui!',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

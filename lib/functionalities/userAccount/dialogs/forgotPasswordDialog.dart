import 'package:flutter/material.dart';
import 'package:project_i_am_in_control/components/validators/text/textValidators.dart';
import 'package:project_i_am_in_control/functionalities/userAccount/dialogs/loginDialog.dart';
import 'package:project_i_am_in_control/functionalities/userAccount/functions/forgotPassword.dart';

import '../../../components/widgets/form/textInput/textInput.dart';

Future<void> openForgotPasswordDialog(context,
    [bool barrierDismissible = false]) {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return ForgotPasswordDialog();
    },
  );
}

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context,) {
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        content: Container(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Row(
                    children: [
                      Text('Esqueceu-se da Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                  Text(
                      'Introduza o seu email associado à sua conta de utilizador, para que possamos proceder ao envio de um pedido de alteração da sua password!',
                      style: TextStyle(
                        fontSize: 13,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                  TextFormInput(
                    controller: _emailController,
                    validator: (value) => requiredValidator(value, this.context),
                    color: Colors.grey[200],
                    widthByTotal: 0.70,
                    placeholder: 'Email',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                  GestureDetector(
                    onTap: () => FirebaseForgotPassword(context, _emailController.text),
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.60),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Enviar',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'antipastobold',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                      )),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Quero tentar novamente! ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          openLoginDialog(context);
                        },
                        child: Text('Regressar',
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
    );
  }
}

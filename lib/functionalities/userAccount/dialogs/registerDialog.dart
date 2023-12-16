import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:project_i_am_in_control/components/validators/text/textValidators.dart';
import 'package:project_i_am_in_control/components/widgets/texts/headingText.dart';
import 'package:project_i_am_in_control/functionalities/userAccount/dialogs/loginDialog.dart';

import '../../../components/widgets/checkbox/checkboxWithLabel.dart';
import '../../../components/widgets/dialogs/errorDialog.dart';
import '../../../components/widgets/form/textInput/textInput.dart';
import '../../../config/appLocalizations/appLocalizations.dart';
import '../../homePage/screens/homeScreen.dart';
import '../functions/signUp.dart';

Future<void> openRegisterDialog(context, [bool barrierDismissible = false]) {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return RegisterDialog();
    },
  );
}

class RegisterDialog extends StatefulWidget {
  const RegisterDialog({Key? key}) : super(key: key);

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {

  int registerStage = 1;
  int selectedAvatar = -1;

  bool isTermsAccepted = false;
  bool isPolicyAccepted = false;

  List avatarIconsList = [
    'assets/images/userIcons/avatarIcon1.png',
    'assets/images/userIcons/avatarIcon2.png',
    'assets/images/userIcons/avatarIcon3.png',
    'assets/images/userIcons/avatarIcon4.png',
  ];

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              content: Container(
                child: registerStage == 1
                    ? Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 10),
                              child: HeadingText(
                                  title: AppLocalization.of(context).translate('welcomeMessage'),
                                  titleSize: 22,
                                  subtitle: AppLocalization.of(context).translate('signUpMessage'),
                                  subTitleSize: 13,
                                  color: Colors.black,
                                  isTitleBold: true),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                            Row(
                              children: [
                                TextFormInput(
                                  controller: _firstNameController,
                                  validator: (value) => requiredValidator(value, this.context),
                                  color: Colors.grey[100],
                                  widthByTotal: 0.33,
                                  placeholder: AppLocalization.of(context).translate('name'),
                                ),
                                SizedBox(width:MediaQuery.of(context).size.height * 0.002),
                                TextFormInput(
                                  controller: _lastNameController,
                                  validator: (value) => requiredValidator(value, this.context),
                                  color: Colors.grey[100],
                                  widthByTotal: 0.33,
                                  placeholder: AppLocalization.of(context).translate('lastName'),
                                ),
                              ],
                            ),
                            SizedBox( height: MediaQuery.of(context).size.height * 0.010),
                            TextFormInput(
                              controller: _emailController,
                              validator: (value) => requiredValidator(value, this.context),
                              color: Colors.grey[100],
                              widthByTotal: 0.70,
                              placeholder: AppLocalization.of(context).translate('email'),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                            TextFormInput(
                              controller: _passwordController,
                              validator: (value) => requiredValidator(value, this.context),
                              color: Colors.grey[100],
                              widthByTotal: 0.70,
                              placeholder: AppLocalization.of(context).translate('password'),
                              isPassword: true,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                            TextFormInput(
                              controller: _confirmpasswordController,
                              validator: (value) => confirmPasswordValidator(value, _passwordController.text, this.context),
                              color: Colors.grey[100],
                              widthByTotal: 0.70,
                              placeholder: AppLocalization.of(context).translate('confirmPassword'),
                              isPassword: true,
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus || currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                    setState(() => registerStage = 2);
                                  } else {
                                    setState(() => registerStage = 2);
                                  }
                                }
                              },
                              child: Container(
                                width: (MediaQuery.of(context).size.width * 0.60),
                                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                        child: Text(AppLocalization.of(context).translate('continue'),
                                            style: const TextStyle(
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
                                Text(AppLocalization.of(context).translate('alreadyMember'), 
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    openLoginDialog(context);
                                  },
                                  child: Text(AppLocalization.of(context).translate('login'),
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Expanded(
                                  child:  Divider(
                                    indent: MediaQuery.of(context).size.width * 0.085,
                                    endIndent: MediaQuery.of(context).size.width * 0.035,
                                    thickness: 1,
                                  ),
                                ),
                                Text(AppLocalization.of(context).translate('or'), style: TextStyle(color: Colors.grey),
                                ),
                                Expanded(
                                  child:  Divider(
                                    indent: MediaQuery.of(context).size.width * 0.035,
                                    endIndent: MediaQuery.of(context).size.width * 0.085,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.050,
                                decoration: BoxDecoration(color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: 
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Wrap(
                                      spacing: 22,
                                      children: [
                                        Image.asset('assets/images/logos/googleIcon.png',
                                          width: MediaQuery.of(context).size.height * 0.025,
                                        ),
                                        Text(AppLocalization.of(context).translate('continueWithGoogle'), 
                                          style: const TextStyle(fontSize: 12, fontFamily: 'lato', fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, top: 10),
                          child: const HeadingText(
                              title: 'Por último,', //traducao
                              titleSize: 22,
                              subtitle: 'Seleciona o teu avatar!', //traducao
                              subTitleSize: 13,
                              color: Colors.black,
                              isTitleBold: true),
                        ),
                        Column(
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width * 0.60, height: MediaQuery.of(context).size.height * 0.30,
                              child: Center(
                                child: GridView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (2 / 1.7)),
                                    itemCount: avatarIconsList.length,
                                    itemBuilder:(BuildContext context, int index) {
                                      return Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(1),
                                                  spreadRadius: 1,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              border: selectedAvatar == index ? Border.all(color: Colors.black, width: 2) : Border.all(color: Colors.white, width: 2),
                                              borderRadius: BorderRadius.circular(5)),
                                          child: GestureDetector(
                                            child: Image.asset(
                                              avatarIconsList[index],
                                              width: MediaQuery.of(context).size.width * 0.22,
                                            ),
                                            onTap: () => setState(() => selectedAvatar = index),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              CheckboxWithLabel(
                                onChanged: ((value) => setState(() => isTermsAccepted = value!)),
                                value: isTermsAccepted,
                                label: Row(
                                  children: [
                                    const Text('Aceito os ', style: const TextStyle(fontSize: 11)),
                                    GestureDetector(
                                      onTap: () => setState(() => isTermsAccepted),
                                      child: const Text('Termos e condições',
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w800,
                                              decoration: TextDecoration.underline)),
                                    ),
                                  ],
                                ),
                              ),
                              CheckboxWithLabel(
                                onChanged: (value) => setState(() => isPolicyAccepted = value!),
                                value: isPolicyAccepted,
                                label: Row(
                                  children: [
                                    const Text('Aceito a ', style: const TextStyle(fontSize: 11)),
                                    GestureDetector(
                                      onTap: () => setState(() => isPolicyAccepted),
                                      child: const Text('Política de privacidade',
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w800,
                                              decoration: TextDecoration.underline)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                        GestureDetector(
                          onTap: () {
                            if(!isPolicyAccepted){
                              openErrorDialog(context, 'Mensagem Policy'); return; //traducao
                            }
                            if(!isTermsAccepted){
                              openErrorDialog(context, 'errorMessage'); return; //traducao
                            }
                            if (selectedAvatar >= 1) {
                              FirebaseSignUp(
                                  context,
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  avatarIconsList[selectedAvatar],
                                  HomeScreen());
                            } else {
                              openErrorDialog(context, 'É obrigatório selecionar um avatar!'); return;
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                            child: const Center(
                                child: const Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text('Finalizar Registo',
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
                        GestureDetector(
                          onTap: () => setState(() => registerStage = 1),
                          child: Wrap(
                            spacing: 5,
                            children: [
                              Icon(PhosphorIcons.arrowArcLeftBold, size: 15, color: Colors.grey[800]),
                              Text('Voltar atrás',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11))
                            ],
                          ),
                        ),
                      ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

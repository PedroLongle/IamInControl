


import '../../../config/appLocalizations/appLocalizations.dart';

String? requiredValidator(String? value, context) {
        if (value == null || value.isEmpty) {
          return AppLocalization.of(context).translate('required');
        } 
        return null;
}

String? confirmPasswordValidator(String? value, String? existingValue, context) {

  if (value == null || value.isEmpty) {
    return AppLocalization.of(context).translate('required');
  }
  if(value != existingValue){
    return AppLocalization.of(context).translate('passwordNotMatch');
  }
  return null;
}

String? emailValidator(String? value, context) {

  final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
  if (value == null || value.isEmpty) {
    return AppLocalization.of(context).translate('required');
  }
  if (emailRegExp.hasMatch(value)) {
    return 'Email is not valid'; //traducao
  }
  return null;
}


import '../constants/app_strings.dart';


class Validators {
  static final RegExp nameRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');

  Validators._();

  static String? validateEmpty(String? v) {
    if (v!.isEmpty) {
      return AppStrings.fieldCantBeEmpty;
    } else {
      return null;
    }
  }



  static String? validateName(String? v) {
    if (v!.isEmpty) {
      return AppStrings.fieldCantBeEmpty;
    } else if (nameRegExp.hasMatch(v)) {
      return AppStrings.enterVaildName;
    } else {
      return null;
    }
  }

  static String? validateTEmpty(dynamic v) {
    if (v == null) {
      return AppStrings.fieldCantBeEmpty;
    } else {
      return null;
    }
  }

  static String? validateEmail(String? v) {
    if (v!.isEmpty) {
      return AppStrings.emailCantBeEmpty;
    }
    // else if (!GetUtils.isEmail(v.replaceAll(RegExp(r"\s+"), ""))) {
    //   return AppStrings.enterValidEmail;
    // }
    else {
      return null;
    }
  }

  static String? validatePhone(String? v) {
    if (v!.isEmpty) {
      return AppStrings.numberCantBeEmpty;
    } else if (v.length != 10) {
      return AppStrings.enterValidNumber;
    } else {
      return null;
    }
  }

  static String? validateEmailPhone(String? v) {
    if (v!.isEmpty) {
      return AppStrings.fieldCantBeEmpty;
    }
    // else if (GetUtils.isNumericOnly(v)) {
    //   return validatePhone(v);
    // }
    else {
      return validateEmail(v);
    }
  }

  static String? validatePassword(String? v) {
    if (v!.isEmpty) {
      return AppStrings.passwordCantBeEmpty;
    } else if (v.length < 2) {
      return AppStrings.passwordValidation;
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String v, String password) {
    if (v.isEmpty || password.isEmpty) {
      return AppStrings.confirmPasswordCantBeEmpty;
    } else if ( v != password) {
      return AppStrings.confirmPasswordValidation;
    } else {
      return null;
    }
  }

  static String? validateOtp(String v) {
    if (v.isEmpty) {
      return AppStrings.fieldCantBeEmpty;
    } else if (v.length < 6) {
      return AppStrings.otpValidation;
    } else {
      return null;
    }
  }

  static String? validateCheckbox({
    bool v = false,
    String error = AppStrings.categoryType,
  }) {
    if (!v) {
      return error;
    } else {
      return null;
    }
  }
}

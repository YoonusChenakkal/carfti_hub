import 'package:flutter/material.dart';

// Decorotion
_outlinedBorder(Color borderColor) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(
      color: borderColor,
      width: 2.0,
    ),
  );
}

InputDecoration textFormFieldDecoration({
  required String hinttext,
  required IconData prefixIcon,
  suffix,
}) {
  return InputDecoration(
      hintText: hinttext,
      prefixIcon: Icon(
        prefixIcon,
        color: Colors.cyan[700],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      // Default border (without focus)
      border: _outlinedBorder(
        Colors.grey.shade300,
      ),
      disabledBorder: _outlinedBorder(
        Colors.grey.shade300,
      ),
      // Border when field is enabled but not focused
      enabledBorder: _outlinedBorder(
        Colors.grey.shade300,
      ),

      // Border when field is focused
      focusedBorder: _outlinedBorder(
        Colors.cyan, // Change to desired focus color
      ),

      // Border when there is an error
      errorBorder: _outlinedBorder(
        Colors.red,
      ),

      // Border when field is focused AND has an error
      focusedErrorBorder: _outlinedBorder(
        Colors.redAccent,
      ),
      suffixIcon: suffix);
}

//  Text Field Validators

String fieldRequired = "This Field Is Required";
String errorEmail = "Email Is Not Valid";
String spaceError = "Spaces Not Allowed use `_` or `-` instead";
String passwordDontMatch = 'Password Not Matching';

final RegExp emailRegExp =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
final RegExp spaceRegExp = RegExp(r'\s+');

String? emptyCheckValidatorWithNoSpace(String? value) {
  if (value == null || value.isEmpty) {
    return fieldRequired;
  } else if (spaceRegExp.hasMatch(value)) {
    return spaceError;
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return fieldRequired;
  } else if (!emailRegExp.hasMatch(value)) {
    return errorEmail;
  }
  return null;
}

String? emptyCheckValidator(String? value) {
  if (value == null || value.isEmpty) {
    return fieldRequired;
  }
  return null;
}

String? confirmPasswordValidator(String? value, String? password) {
  if (value == null || value.isEmpty) {
    return fieldRequired;
  } else if (password != null && value != password) {
    return passwordDontMatch;
  }
  return null;
}

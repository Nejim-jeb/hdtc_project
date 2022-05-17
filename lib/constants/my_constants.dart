import 'package:flutter/material.dart';

//0xffc3b55f
class MyConstants {
  static String testPhoto =
      'https://images.unsplash.com/photo-1650357519740-c888919621f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80';
  static String firestoreMasterCollectionPath = 'master';
  static String firestoreBachelorCollectionPath = 'bachelor';
  static String firestoredoctorateCollectionPath = 'doctorate';
  static String firestoreUniCollectionPath = 'universities';
  static Color secondaryColor = const Color(0xff584f3f);
  static Color primaryColor = const Color(0xffc2b369);
  static Color appGrey = const Color(0xff8b8b8b);
  static List<String> langList = [
    'english',
    'arabic',
    'turkish',
  ];

  static InputDecoration formTextFieldInputDecoration(
      {required String hintText}) {
    return InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          color: MyConstants.primaryColor,
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade800),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade900)));
  }

  static InputDecoration formDropDownInputDecoration(
      {required String hintText, bool? isEnabled}) {
    return InputDecoration(
        enabled: isEnabled == false ? false : true,
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        labelText: hintText,
        labelStyle: TextStyle(
          color: MyConstants.secondaryColor,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyConstants.primaryColor)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: MyConstants.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade900)));
  }
}

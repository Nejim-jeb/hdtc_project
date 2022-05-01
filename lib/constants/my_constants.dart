import 'package:flutter/material.dart';

class MyConstants {
  static String testPhoto =
      'https://images.unsplash.com/photo-1650357519740-c888919621f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80';
  static String firestoreMasterCollectionPath = 'master';
  static String firestoreBachelorCollectionPath = 'bachelor';
  static String firestoredoctorateCollectionPath = 'doctorate';
  static String firestoreUniCollectionPath = 'universities';

  static InputDecoration formTextFieldInputDecoration(
      {required String hintText}) {
    return InputDecoration(
        labelText: hintText,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade800),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade800)));
  }
}

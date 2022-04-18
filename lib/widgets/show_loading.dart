import 'package:flutter/material.dart';

class ShowLoading extends StatelessWidget {
  const ShowLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

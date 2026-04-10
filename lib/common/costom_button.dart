import 'package:flutter/material.dart';

class CostomButton extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;

  const CostomButton({ 
    super.key, 
    required this.text,
    required this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50)
      ),
      child: Text(text),
    );
  }

}
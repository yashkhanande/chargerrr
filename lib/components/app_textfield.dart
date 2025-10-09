import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool password;
  final TextInputType type;

  const AppTextfield ({super.key, required this.hint, required this.icon, required this.controller, required this.password, required this.type});
  @override
  Widget build(BuildContext context) {
    return TextField(
            keyboardType: type,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            obscureText: password,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              hint: Text(hint),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.1),
              border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(12)),
              alignLabelWithHint: true,
            ),
            style: const TextStyle(color: Colors.white),
          );
  }
}
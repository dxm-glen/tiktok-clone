import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/FormButton.dart';

class LoginFromScreen extends StatefulWidget {
  const LoginFromScreen({super.key});

  @override
  State<LoginFromScreen> createState() => _LoginFromScreenState();
}

class _LoginFromScreenState extends State<LoginFromScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print(formData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required.';
                  }

                  // 이메일 정규식 검증
                  String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return 'Enter a valid email address.';
                  }

                  return null; // 올바른 입력인 경우
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData["email"] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required.';
                  }

                  // 비밀번호 길이 검증
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long.';
                  }

                  return null; // 올바른 입력인 경우
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData["password"] = newValue;
                  }
                },
              ),
              Gaps.v28,
              GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(disabled: false, text: "Next"))
            ],
          ),
        ),
      ),
    );
  }
}

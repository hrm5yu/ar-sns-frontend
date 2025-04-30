import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ログイン')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authService.signIn(emailController.text, passwordController.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ログイン失敗: $e')));
                }
              },
              child: Text('ログイン'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await authService.signUp(emailController.text, passwordController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('アカウント作成成功')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('アカウント作成失敗: $e')));
                }
              },
              child: Text('新規登録はこちら'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(child: Text('ログイン成功！')),
    );
  }
}
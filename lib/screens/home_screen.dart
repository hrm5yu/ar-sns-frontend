import 'package:ar_sns_frontend/screens/login_screen.dart';
import 'package:ar_sns_frontend/screens/postform_screen.dart';
import 'package:ar_sns_frontend/screens/profile_screen.dart';
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen())
                );
            },
          ),
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NewPostScreen())
              );
            if (result == 'posted') {
              //投稿時のリロード処理入れる予定
              print('投稿されました');
            }
            }
          ),
          IconButton(
            icon: Icon(Icons.man),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen())
              );
            }
          )
        ],
      ),
      body: Center(child: Text('ログイン成功！')),
    );
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  final String baseUrl = 'https://shielded-plateau-65128-36001a8690eb.herokuapp.com';

  Future<http.Response> getProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('未ログイン');

    final idToken = await user.getIdToken();

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('プロフィール取得に失敗: ${response.statusCode}, ${response.body}');
    }

    return response;
  }

  Future<void> createPost(String text) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception('未ログイン');
  final idToken = await user.getIdToken();

  final response = await http.post(
    Uri.parse('$baseUrl/posts'),
    headers: {
      'Authorization': 'Bearer $idToken',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'latitude': 1,
      'longitude': 1,
      'text': text
      }),
  );

  if (response.statusCode != 201) {
    throw Exception('投稿に失敗: ${response.body}');
  }
}

}


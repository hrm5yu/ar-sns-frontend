import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _apiService = ApiService();
  String? _profileData;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await _apiService.getProfile();
      final data = jsonDecode(response.body);
      setState(() {
        _profileData = data.toString();
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () async {
              Navigator.pop(context);
            }
          )
          ]),
      body: Center(
        child: _error != null
            ? Text('エラー: $_error')
            : _profileData != null
                ? Text('プロフィール情報:\n$_profileData')
                : CircularProgressIndicator(),
      ),
    );
  }
}

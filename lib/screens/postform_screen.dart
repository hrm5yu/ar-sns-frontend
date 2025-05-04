import 'package:flutter/material.dart';
import '../services/api_service.dart';

class NewPostScreen extends StatefulWidget {
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _textController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _submitPost() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _apiService.createPost(text); // ← ここでAPI呼び出し
      Navigator.pop(context, 'posted'); // 投稿後に前の画面に戻る
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('新規投稿')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '投稿内容を入力してください',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            if (_errorMessage != null) Text('エラー: $_errorMessage', style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitPost,
              child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('投稿'),
            ),
          ],
        ),
      ),
    );
  }
}

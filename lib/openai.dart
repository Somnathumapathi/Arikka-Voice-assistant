import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:arikka/apikey.dart';

class OpenAi {
  final List<Map<String, String>> messages = [];
  Future<String> isImagePrompt(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apikey",
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content":
                    "Is this prompt asking to draw or generate an ai art or image or picture? Just tell yes or no."
              },
            ],
          },
        ),
      );
      print(res.body);
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)['choices'][0]['content'] == null) {
          print("Response is null");
        }
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.toLowerCase();

        if (content.contains("yes")) {
          final res = await dallEApi(prompt);
          return res;
        } else {
          final res = await chatGptApi(prompt);
          return res;
        }
      }
      return 'SomeThing went wrong';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGptApi(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apikey"
        },
        body: jsonEncode(
          {"model": "gpt-3.5-turbo", "messages": messages},
        ),
      );
      print("chatGptApi - API Response: ${res.body}");
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({'role': 'assistant', 'content': content});
        return content;
      }
      return 'SomeThing went wrong';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEApi(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apikey"
        },
        body: jsonEncode(
          {
            'prompt': prompt,
            'n': 1,
          },
        ),
      );
      print("dallEApi - API Response: ${res.body}");
      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trimRight();

        messages.add({'role': 'assistant', 'content': imageUrl});
        return imageUrl;
      }
      return 'SomeThing went wrong';
    } catch (e) {
      return e.toString();
    }
  }
}

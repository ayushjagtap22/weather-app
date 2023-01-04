import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;
  ApiClient({
    required this.client,
  });

  dynamic get(String path) async {}
}

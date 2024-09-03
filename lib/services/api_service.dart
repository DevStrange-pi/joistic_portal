import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/company.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Company>> fetchCompanies() async {
    final response = await http.get(Uri.parse('$_baseUrl/albums/1/photos'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Company> companies = data.map((json) => Company.fromJson(json)).toList();
      // Restrict title to 2 words and description to 1 line
      companies = companies.map((company) {
        List<String> words = company.title.split(' ');
        String companyName = words.length >= 2
            ? '${words[0]} ${words[1]}'
            : company.title;
        return Company(
          id: company.id,
          title: companyName,
          desc: company.title,
          thumbnailUrl: company.thumbnailUrl,
          url: company.url
        );
      }).toList();
      return companies;
    } else {
      throw Exception('Failed to load companies');
    }
  }
}
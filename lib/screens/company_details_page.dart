import 'package:flutter/material.dart';

import '../models/company.dart';

class CompanyDetailPage extends StatelessWidget {
  final Company company;

  CompanyDetailPage({required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(company.thumbnailUrl),
            SizedBox(height: 10),
            Text(
              company.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              company.title, // Description restricted to one line
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Additional details can be added here
          ],
        ),
      ),
    );
  }
}

class Company {
  final int id;
  final String title;
  final String desc;
  final String thumbnailUrl;
  final String url;
  bool isApplied;

  Company({
    required this.id,
    required this.title,
    this.desc = "",
    required this.thumbnailUrl,
    required this.url,
    this.isApplied = false,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      title: json['title'],
      desc: json['desc'] ?? "",
      thumbnailUrl: json['thumbnailUrl'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'thumbnailUrl': thumbnailUrl,
      'url': url,
      'isApplied': isApplied,
    };
  }
}

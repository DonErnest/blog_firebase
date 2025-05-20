class Post {
  final String id;
  final String title;
  final String text;
  final DateTime createdOn;

  const Post({
    required this.id,
    required this.title,
    required this.text,
    required this.createdOn,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      title: json["title"],
      text: json["text"],
      createdOn: DateTime.parse(json["createdOn"]),
    );
  }

  String get createdOnDisplay {
    return '${createdOn.day}.${createdOn.month}.${createdOn.year}';
  }
}

class AddPost {
  final String text;
  final String title;

  AddPost({required this.text, required this.title});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'title': title,
      'createdOn': DateTime.now().toIso8601String(),
    };
  }
}

class UpdatePost {
  final String text;
  final String title;
  final String createdOn;

  UpdatePost({
    required this.text,
    required this.title,
    required this.createdOn,
  });

  factory UpdatePost.fromJson(Map<String, dynamic> json) {
    return UpdatePost(
      title: json["title"],
      text: json["text"],
      createdOn: json["createdOn"],
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'title': title, "createdOn": createdOn};
  }
}

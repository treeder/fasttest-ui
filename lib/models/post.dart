class Post {
  String id;
  String title;
  Post({this.id, this.title});

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'];
  // email = json['email'],
  // photoURL = json['photo_url'],
  // createdAt = DateTime.parse(json['created_at']),
  // updatedAt = DateTime.parse(json['updated_at']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        // 'display_name': name,
        // 'email': email,
        // 'photo_url': photoURL,
      };

  static Post fromJsonStatic(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }
}

// List<Post> posts = [
//   Post(id: "123", title: "Something!"),
//   Post(id: "234", title: "Another thing!")
// ];

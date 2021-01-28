class Post {
  String id;
  String title;
  Post({this.id, this.title});
}

List<Post> posts = [
  Post(id: "123", title: "Something!"),
  Post(id: "234", title: "Another thing!")
];

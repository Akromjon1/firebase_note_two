class Post {
  late int id;
  late String userId;
  late String title;
  late String content;
  late String name;
  late String lastName;
  String? image;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    this.image, required this.name, required this.lastName});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    name = json['name'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'content': content,
    'image': image,
    'name': name,
    'lastName': lastName,
  };
}
class ReviewsList {
  final List<Review> review;

  ReviewsList(this.review);
}

class Review {
  final dynamic name;
  final dynamic username;
  final dynamic avatarPath;
  final dynamic rating;
  final dynamic content;
  final dynamic createdAt;

  Review({
    this.username,
    this.avatarPath,
    required this.rating,
    required this.content,
    required this.createdAt,
    required this.name,
  });

  factory Review.fromJson(dynamic json) {
    if (json == null) {
      return Review(
          name: '',
          username: '',
          avatarPath: '',
          rating: '',
          content: '',
          createdAt: '');
    }

    return Review(
      name: json['name'],
      username: json['username'],
      avatarPath: json['avatar_path'],
      createdAt: json['created_at'],
      content: json['content'],
      rating: json['rating'],
    );
  }
}

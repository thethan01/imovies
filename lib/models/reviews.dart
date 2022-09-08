class ReviewsList {
  final List<Review> review;

  ReviewsList(this.review);
}

class Review {
  final dynamic author;
  final dynamic avatarPath;
  final dynamic rating;
  final dynamic content;
  final dynamic createdAt;

  Review({
    this.avatarPath,
    required this.rating,
    required this.content,
    required this.createdAt,
    required this.author,
  });

  factory Review.fromJson(dynamic json) {
    if (json == null) {
      return Review(
          author: '',
          avatarPath: '',
          rating: '',
          content: '',
          createdAt: '');
    }

    return Review(
      author: json['author'],
      avatarPath: json['avatar_path'],
      createdAt: json['created_at'],
      content: json['content'],
      rating: json['rating'],
    );
  }
}

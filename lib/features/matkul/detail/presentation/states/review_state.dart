part of '_states.dart';

class ReviewState {
  final thisAuthor = 'Rayhan Maulana Akbar';
  final likedReviews = <String, List<ReviewModel>>{};
  final reviews = <String, List<ReviewModel>>{
    'Kecerdasan Artifisial dan Sains Data Dasar': [
      ReviewModel(
          author: 'Astrida Nayla',
          matkul: 'Kecerdasan Artifisial dan Sains Data Dasar',
          likesCount: 0,
          classTakenOn: 'Ganjil 2020/2021'),
      ReviewModel(
          author: 'Thalia Theresa',
          matkul: 'Kecerdasan Artifisial dan Sains Data Dasar',
          likesCount: 3,
          classTakenOn: 'Ganjil 2020/2021'),
      ReviewModel(
          author: 'Rayhan Maulana Akbar',
          matkul: 'Kecerdasan Artifisial dan Sains Data Dasar',
          likesCount: 2,
          classTakenOn: 'Ganjil 2020/2021'),
    ],
    'Basis Data': [],
    'Pemrograman Lanjut': [],
    'Matematika Dasar 1': [],
    'Matematika Diskret 1': [],
    'Arsitektur dan Pemrograman Aplikasi Perusahaan' : []
  };

  // getter
  // TODO: add delay(?)
  List<ReviewModel>? getReviews(String matkul) => reviews[matkul];

  void addReview(String matkul, ReviewModel review) =>
      reviews[matkul]!.add(review);

  ReviewModel? findOwnedReview(String matkul) {
    // Error
    if (reviews[matkul] == null) {
      return null;
    }

    for (final review in reviews[matkul]!) {
      if (review.author == thisAuthor) {
        return review;
      }
    }
    // Empty model -> Not found
    return ReviewModel();
  }

  void click(String matkul, ReviewModel review) {
    likedReviews.putIfAbsent(matkul, () => []);
    if (!likedReviews[matkul]!.contains(review)) {
      like(matkul, review);
    } else {
      unlike(matkul, review);
    }
  }

  void like(String matkul, ReviewModel review) {
    // TODO: update likeCount to db (?)
    review.likesCount = review.likesCount! + 1;
    likedReviews[matkul]!.add(review);
  }

  void unlike(String matkul, ReviewModel review) {
    // TODO: update likeCount to db (?)
    review.likesCount = review.likesCount! - 1;
    likedReviews[matkul]!.remove(review);
  }

  bool isLiked(String matkul, ReviewModel review) {
    if (!likedReviews.containsKey(matkul)) {
      return false;
    }
    return likedReviews[matkul]!.contains(review);
  }
}

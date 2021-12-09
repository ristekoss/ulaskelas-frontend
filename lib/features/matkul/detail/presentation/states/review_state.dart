part of '_states.dart';

class ReviewState {
  final thisAuthor = 'Rayhan Maulana Akbar Panjang Bangetttttt UHUY UHUY UHUY';
  final likedReviews = <String, List<ReviewModel>>{};
  final reviews = <String, List<ReviewModel>>{
    'Kecerdasan Artifisial dan Sains Data Dasar': [
      ReviewModel(
          author: 'Astrida Nayla',
          matkul: 'Kecerdasan Artifisial dan Sains Data Dasar',
          description: 'Lorem ipsum dolor sit amet, adisplis '
              'consectetur adipiscing elit, sed do '
              'eiusmod tempor incididun ut labore et '
              'dolore magna aliqua. Ut enim ad minim veniam, '
              'quis nostrud exercitation ullamco laboris '
              'nisi ut aliquip ex ea commodot.',
          likesCount: 999,
          classTakenOn: 'Ganjil 2020/2021',
          reviewedOn: DateTime(2021, 10, 11)),
      ReviewModel(
          author: 'Thalia Theresa',
          matkul: 'Kecerdasan Artifisial dan Sains Data Dasar',
          description: 'Lorem ipsum dolor sit amet, adisplis '
              'consectetur adipiscing elit, sed do '
              'eiusmod tempor incididun ut labore et '
              'dolore magna aliqua. Ut enim ad minim veniam, '
              'quis nostrud exercitation ullamco laboris '
              'nisi ut aliquip ex ea commodot.',
          likesCount: 9,
          classTakenOn: 'Ganjil 2020/2021',
          reviewedOn: DateTime(2021, 10, 11)),
      ReviewModel(
          author: 'Rayhan Maulana Akbar Panjang Bangetttttt UHUY UHUY UHUY',
          matkul: 'Kecerdasan Artifisial dan Sains Data Dasar',
          description: 'Lorem ipsum dolor sit amet, adisplis '
              'consectetur adipiscing elit, sed do '
              'eiusmod tempor incididun ut labore et '
              'dolore magna aliqua. Ut enim ad minim veniam, '
              'quis nostrud exercitation ullamco laboris '
              'nisi ut aliquip ex ea commodot.',
          likesCount: 98,
          classTakenOn: 'Ganjil 2020/2021',
          reviewedOn: DateTime(2021, 10, 11),
          status: 'Approved'),
    ],
    'Basis Data': [],
    'Pemrograman Lanjut': [],
    'Matematika Dasar 1': [],
    'Matematika Diskret 1': [],
    'Arsitektur dan Pemrograman Aplikasi Perusahaan': []
  };

  // getter
  // TODO: add delay(?)
  List<ReviewModel>? getReviews(String matkul) => reviews[matkul];

  void addReview(String matkul, ReviewModel review) => reviews[matkul]!.add(review);

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

  Future<void> like(String matkul, ReviewModel review) async {
    // TODO: update likeCount to db (?)
    final response = await http.post(Uri.parse(Endpoints.likes), body: {
      'review_id': review.id,
      'is_like': true,
    });
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['error'].toString() == 'null') {
        review.likesCount = review.likesCount! + 1;
        likedReviews[matkul]!.add(review);
      }
    }
  }

  Future<void> unlike(String matkul, ReviewModel review) async {
    // TODO: update likeCount to db (?)
    final response = await http.post(Uri.parse(Endpoints.likes), body: {
      'review_id': review.id,
      'is_like': false,
    });
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['error'].toString() == 'null') {
        review.likesCount = review.likesCount! - 1;
        likedReviews[matkul]!.remove(review);
      }
    }
  }

  bool isLiked(String matkul, ReviewModel review) {
    if (!likedReviews.containsKey(matkul)) {
      return false;
    }
    return likedReviews[matkul]!.contains(review);
  }
}

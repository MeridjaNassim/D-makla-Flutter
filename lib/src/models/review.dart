class Review {
  String id;
  String name;
  String review;
  String image;
  String reviewsNumber;
  String followersNumber;
  String rate;

  Review(this.id, this.name, this.review, this.image, this.reviewsNumber, this.followersNumber, this.rate);
}

class ReviewsList {
  List<Review> _reviewsList;

  List<Review> get reviewsList => _reviewsList;

  ReviewsList() {
    this._reviewsList = [
      new Review(
          'rev0',
          'Leonard A. Brown',
          'European colonization of the Americas brought about the introduction of a large number of new ingredients',
          'img/user0.jpg',
          '545',
          '415',
          '5'),
      new Review(
          'rev1',
          'Clifford J. Estes',
          'Americas brought about the introduction of a large number of new ingredients',
          'img/user1.jpg',
          '752',
          '465',
          '4'),
      new Review('rev2', 'Brian L. Flores', 'The introduction of a large number of new ingredients', 'img/user2.jpg',
          '103', '192', '3'),
      new Review(
          'rev3',
          'Scott M. Scott',
          'Foods that predate colonization, and the European colonization of the Americas brought about the introduction of a large number of new ingredients',
          'img/user3.jpg',
          '233',
          '155',
          '4'),
      new Review(
          'rev4',
          'Lila W. Floyd',
          'European colonization of the Americas brought about the introduction of a large number of new ingredients',
          'img/user3.jpg',
          '1555',
          '2415',
          '2'),
      new Review(
          'rev5',
          'Laurie Z. Bergeron',
          'European colonization of the Americas brought about the introduction of a large number of new ingredients',
          'img/user2.jpg',
          '4553',
          '545',
          '3'),
      new Review(
          'rev6',
          'Edward E. Linn',
          'There are a few foods that predate colonization, and the European colonization of the Americas brought about the introduction of a large number of new ingredients',
          'img/user1.jpg',
          '554',
          '155',
          '2'),
      new Review(
          'rev7',
          'George T. Larkin',
          'There are a few foods that predate colonization, and the European colonization of the Americas brought about the introduction of a large number of new ingredients',
          'img/user3.jpg',
          '4144',
          '1565',
          '5'),
      new Review(
          'rev8',
          'Cecil M. Tuck',
          'There are a few foods that predate colonization, and the European colonization of the Americas brought about the introduction of a large number of new ingredients',
          'img/user2.jpg',
          '4441',
          '155',
          '4'),
      new Review(
          'rev9',
          'Troy D. Cordeiro',
          'There are a few foods that predate colonization, and the European colonization of the Americas brought about the introduction of a large number of new ingredients',
          'img/user0.jpg',
          '153',
          '226',
          '3'),
    ];
  }
}

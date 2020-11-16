class Notification {
  String image;
  String title;
  String time;

  Notification(this.image, this.title, this.time);
}

class NotificationList {
  List<Notification> _notifications;

  NotificationList() {
    this._notifications = [
      new Notification(
          'img/food1.jpg', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', '33min ago'),
      new Notification('img/food2.jpg', 'It is a long established fact that a reader will be distracted', '32min ago'),
      new Notification('img/user3.jpg', 'There are many variations of passages of Lorem Ipsum available', '34min ago'),
      new Notification(
          'img/food4.jpg', 'Contrary to popular belief, Lorem Ipsum is not simply random text', '52min ago'),
      new Notification(
          'img/food5.jpg', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', '10min ago'),
      new Notification('img/user0.jpg', 'It is a long established fact that a reader will be distracted', '12min ago'),
      new Notification(
          'img/food2.jpg', 'There are many variations of passages of Lorem Ipsum available', '2 hours ago'),
      new Notification(
          'img/user1.jpg', 'Contrary to popular belief, Lorem Ipsum is not simply random text', '1 day ago'),
    ];
  }

  List<Notification> get notifications => _notifications;
}

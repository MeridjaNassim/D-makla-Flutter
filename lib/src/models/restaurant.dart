class Restaurant {
  String id;
  String name;
  String description;
  int rate;
  String address;
  String image;
  String phone;
  String mobile;
  String information;
  List<String> gallery = [
    'img/food0.jpg',
    'img/food1.jpg',
    'img/food2.jpg',
    'img/food3.jpg',
    'img/food4.jpg',
    'img/food5.jpg'
  ];
  double lat = 37.42;
  double lon = -122.08;

  Restaurant(this.id, this.name, this.description, this.rate, this.address, this.image, this.phone, this.mobile,
      this.information, this.lat, this.lon);
}

class RestaurantsList {
  List<Restaurant> _restaurantsList;

  List<Restaurant> _popularRestaurantsList;

  List<Restaurant> get popularRestaurantsList => _popularRestaurantsList;
  List<Restaurant> get restaurantsList => _restaurantsList;

  RestaurantsList() {
    this._restaurantsList = [
      new Restaurant(
          'rest0',
          'Party Fowl',
          'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          3,
          'Aldus PageMaker including versions of Lorem Ipsum',
          'img/food0.jpg',
          '+136 226 5669',
          '+163 525 9432',
          'Monday - Thursday    10:00AM - 11:00PM' + '\nFriday - Sunday    12:00PM - 9:00AM',
          37.42796133580664,
          -122.085749655962),
      new Restaurant(
          'rest1',
          'The Dairy Miralova',
          'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          4,
          'Aldus PageMaker including versions of Lorem Ipsum',
          'img/food1.jpg',
          '+136 226 5669',
          '+163 525 9432',
          'Monday - Thursday    10:00AM - 11:00PM' + '\nFriday - Sunday    12:00PM - 5:00AM',
          37.42196133580664,
          -122.086749655962),
      new Restaurant(
          'rest2',
          'Nacho Problem',
          'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          5,
          'Aldus PageMaker including versions of Lorem Ipsum',
          'img/food2.jpg',
          '+136 226 5669',
          '+163 525 9432',
          'Monday - Thursday    10:00AM - 11:00PM' + '\nFriday - Sunday    12:00PM - 5:00AM',
          37.4226133580664,
          -122.086759655962),
      new Restaurant(
          'rest3',
          'Wok N\' Roll',
          'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          2,
          'Aldus PageMaker including versions of Lorem Ipsum',
          'img/food3.jpg',
          '+136 226 5669',
          '+163 525 9432',
          'Monday - Thursday    10:00AM - 11:00PM' + '\nFriday - Sunday    12:00PM - 5:00AM',
          37.42736133580664,
          -122.086750655962),
      new Restaurant(
          'rest4',
          'Traditional Restaurant',
          'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          5,
          'Aldus PageMaker including versions of Lorem Ipsum',
          'img/food4.jpg',
          '+136 226 5669',
          '+163 525 9432',
          'Monday - Thursday    10:00AM - 11:00PM' + '\nFriday - Sunday    12:00PM - 5:00AM',
          37.42790133580664,
          -122.086760655962),
    ];

    this._popularRestaurantsList = [
      new Restaurant(
          'rest1',
          'The Dairy Miralova',
          'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          4,
          'Aldus PageMaker including versions of Lorem Ipsum',
          'img/food1.jpg',
          '+136 226 5669',
          '+163 525 9432',
          'Monday - Thursday    10:00AM - 11:00PM' + '\nFriday - Sunday    12:00PM - 5:00AM',
          37.157,
          -122.086748055962),
      new Restaurant(
          'rest2',
          'Nacho Problem',
          'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          5,
          'Aldus PageMaker including versions of Lorem Ipsum',
          'img/food2.jpg',
          '+136 226 5669',
          '+163 525 9432',
          'Monday - Thursday    10:00AM - 11:00PM' + '\nFriday - Sunday    12:00PM - 5:00AM',
          37.4585,
          -122.37574),
      new Restaurant(
          'rest3',
          'Wok N\' Roll',
          'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          2,
          'Aldus PageMaker including versions of Lorem Ipsum',
          'img/food3.jpg',
          '+136 226 5669',
          '+163 525 9432',
          'Monday - Thursday    10:00AM - 11:00PM' + '\nFriday - Sunday    12:00PM - 5:00AM',
          37.457,
          -122.56785),
      new Restaurant(
          'rest4',
          'Traditional Restaurant',
          'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          5,
          'Aldus PageMaker including versions of Lorem Ipsum',
          'img/food4.jpg',
          '+136 226 5669',
          '+163 525 9432',
          'Monday - Thursday    10:00AM - 11:00PM' + '\nFriday - Sunday    12:00PM - 5:00AM',
          37.68578,
          -122.458),
    ];
  }
}

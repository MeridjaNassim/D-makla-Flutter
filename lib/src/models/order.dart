import 'package:restaurant_rlutter_ui/src/models/food.dart';

class Order {
  String id;
  Food food;
  String date;
  String time;

  Order(this.id, this.food, this.date, this.time);
}

class OrdersList {
  List<Order> _orderedList;
  List<Order> _recentOrderedList;

  List<Order> get orderedList => _orderedList;

  List<Order> get recentOrderedList => _recentOrderedList;

  OrdersList() {
    this._orderedList = [
      new Order(
          'ord0',
          new Food(
            'food1',
            'Calas',
            'Boston Restaurant',
            10.23,
            'img/food1.jpg',
            'Calas are dumplings composed primarily of cooked rice, yeast, sugar, eggs, and flour; the resulting batter is deep-fried. It is traditionally a breakfast dish, served with coffee or cafe au lait, and has a mention in most Creole cuisine cookbooks. Calas are also referred to as Creole rice fritters or rice doughnuts.',
            'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            '435g',
          ),
          '10/12/2020',
          '03.30AM'),
      new Order(
          'ord1',
          new Food(
            'food3',
            'Hawaiian haystack',
            'Hawai Restaurant',
            8.63,
            'img/food3.jpg',
            'A Hawaiian haystack is a type of haystack. It is a convenience cuisine dish composed of a rice base and several toppings. It is prepared by topping rice with toppings such as chicken, chicken gravy, diced pineapple, diced tomatoes, Chinese noodles, cheese, and celery. Traditionally, each topping is prepared in its own dish and presented buffet-style, then added on top of the rice as desired.',
            'Recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            '465g',
          ),
          '10/12/2020',
          '03.30AM'),
      new Order(
          'ord2',
          new Food(
            'food4',
            'Yeung Chow fried rice',
            'NYC Restaurant',
            11.93,
            'img/food4.jpg',
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
            'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            '275g',
          ),
          '10/12/2020',
          '03.30AM'),
      new Order(
          'ord3',
          new Food(
            'food7',
            'Gumbo',
            'Hawai Restaurant',
            4.83,
            'img/food2.jpg',
            'A Hawaiian haystack is a type of haystack. It is a convenience cuisine dish composed of a rice base and several toppings. It is prepared by topping rice with toppings such as chicken, chicken gravy, diced pineapple, diced tomatoes, Chinese noodles, cheese, and celery. Traditionally, each topping is prepared in its own dish and presented buffet-style, then added on top of the rice as desired.',
            'Recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            '435g',
          ),
          '10/12/2020',
          '03.30AM'),
      new Order(
          'ord4',
          new Food(
            'food8',
            'Hokkien fried rice',
            'Cultural Restaurant',
            14.99,
            'img/food0.jpg',
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
            'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            '220g',
          ),
          '10/12/2020',
          '03.30AM'),
      new Order(
          'ord5',
          new Food(
            'food9',
            'Shrimp Creole',
            'SF Restaurant',
            18.63,
            'img/food3.jpg',
            'Shrimp creole is a dish of Louisiana Creole origin, consisting of cooked shrimp in a mixture of whole or diced tomatoes, the Holy trinity of onion, celery and bell pepper, spiced with hot pepper sauce and/or cayenne-based seasoning, and served over steamed or boiled white rice. The shrimp may be cooked in the mixture or cooked separately and added at the end. Other "creole" dishes may be made by substituting some other meat or seafood for the shrimp, or omitting the meat entirely.',
            'Recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            '155g',
          ),
          '10/12/2020',
          '03.30AM'),
    ];

    this._recentOrderedList = [
      new Order(
          'ord0',
          new Food(
            'food7',
            'Gumbo',
            'Hawai Restaurant',
            4.83,
            'img/food2.jpg',
            'A Hawaiian haystack is a type of haystack. It is a convenience cuisine dish composed of a rice base and several toppings. It is prepared by topping rice with toppings such as chicken, chicken gravy, diced pineapple, diced tomatoes, Chinese noodles, cheese, and celery. Traditionally, each topping is prepared in its own dish and presented buffet-style, then added on top of the rice as desired.',
            'Recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            '435g',
          ),
          '10/12/2020',
          '03.30AM'),
      new Order(
          'ord1',
          new Food(
            'food8',
            'Hokkien fried rice',
            'Cultural Restaurant',
            14.99,
            'img/food0.jpg',
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
            'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            '220g',
          ),
          '10/12/2020',
          '03.30AM'),
      new Order(
          'ord2',
          new Food(
            'food9',
            'Shrimp Creole',
            'SF Restaurant',
            18.63,
            'img/food3.jpg',
            'Shrimp creole is a dish of Louisiana Creole origin, consisting of cooked shrimp in a mixture of whole or diced tomatoes, the Holy trinity of onion, celery and bell pepper, spiced with hot pepper sauce and/or cayenne-based seasoning, and served over steamed or boiled white rice. The shrimp may be cooked in the mixture or cooked separately and added at the end. Other "creole" dishes may be made by substituting some other meat or seafood for the shrimp, or omitting the meat entirely.',
            'Recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            '155g',
          ),
          '10/12/2020',
          '03.30AM'),
    ];
  }
}

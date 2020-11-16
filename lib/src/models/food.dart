class Food {
  String id;
  String name;
  String restaurantName;
  double price;
  String image;
  String description;
  String ingredients;
  String weight;

  Food(
      this.id, this.name, this.restaurantName, this.price, this.image, this.description, this.ingredients, this.weight);

  String getPrice({double myPrice}) {
    if (myPrice != null) {
      return '\$${myPrice.toStringAsFixed(2)}';
    }
    return '\$${this.price.toStringAsFixed(2)}';
  }
}

class FoodsList {
  List<Food> _foodsList;
  List<Food> _favoritesList;
  List<Food> _featuredList;

  List<Food> get foodsList => _foodsList;
  List<Food> get favoritesList => _favoritesList;
  List<Food> get featuredList => _featuredList;

  FoodsList() {
    this._foodsList = [
      new Food(
        'food0',
        'American fried rice',
        'NYC Restaurant',
        11.93,
        'img/food0.jpg',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
        'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        '185g',
      ),
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
      new Food(
        'food2',
        'Charleston red rice',
        'SF Restaurant',
        8.63,
        'img/food2.jpg',
        'Charleston red rice or Savannah red rice is a rice dish commonly found along the Southeastern coastal regions of Georgia and South Carolina, known simply as red rice by natives of the region.',
        'Recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        '445g',
      ),
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
      new Food(
        'food5',
        'Spanish rice',
        'Spanish Restaurant',
        10.23,
        'img/food5.jpg',
        'Calas are dumplings composed primarily of cooked rice, yeast, sugar, eggs, and flour; the resulting batter is deep-fried. It is traditionally a breakfast dish, served with coffee or cafe au lait, and has a mention in most Creole cuisine cookbooks. Calas are also referred to as Creole rice fritters or rice doughnuts.',
        'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        '285g',
      ),
      new Food(
        'food6',
        'Jambalaya',
        'SF Restaurant',
        18.63,
        'img/food1.jpg',
        'Charleston red rice or Savannah red rice is a rice dish commonly found along the Southeastern coastal regions of Georgia and South Carolina, known simply as red rice by natives of the region.',
        'Recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        '155g',
      ),
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
    ];

    this._favoritesList = [
      new Food(
        'food0',
        'American fried rice',
        'NYC Restaurant',
        11.93,
        'img/food0.jpg',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
        'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        '185g',
      ),
      new Food(
        'food2',
        'Charleston red rice',
        'SF Restaurant',
        8.63,
        'img/food2.jpg',
        'Charleston red rice or Savannah red rice is a rice dish commonly found along the Southeastern coastal regions of Georgia and South Carolina, known simply as red rice by natives of the region.',
        'Recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        '445g',
      ),
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
      new Food(
        'food5',
        'Spanish rice',
        'Spanish Restaurant',
        10.23,
        'img/food5.jpg',
        'Calas are dumplings composed primarily of cooked rice, yeast, sugar, eggs, and flour; the resulting batter is deep-fried. It is traditionally a breakfast dish, served with coffee or cafe au lait, and has a mention in most Creole cuisine cookbooks. Calas are also referred to as Creole rice fritters or rice doughnuts.',
        'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        '285g',
      ),
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
    ];

    this._featuredList = [
      new Food(
        'food0',
        'American fried rice',
        'NYC Restaurant',
        11.93,
        'img/food0.jpg',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
        'Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        '185g',
      ),
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
      new Food(
        'food3',
        'Hawaiian haystack',
        'Hawai Restaurant',
        8.63,
        'img/food2.jpg',
        'A Hawaiian haystack is a type of haystack. It is a convenience cuisine dish composed of a rice base and several toppings. It is prepared by topping rice with toppings such as chicken, chicken gravy, diced pineapple, diced tomatoes, Chinese noodles, cheese, and celery. Traditionally, each topping is prepared in its own dish and presented buffet-style, then added on top of the rice as desired.',
        'Recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
        '465g',
      ),
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
    ];
  }
}

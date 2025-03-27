import 'package:figma_foodapp/category_model.dart';
import 'package:figma_foodapp/product_model.dart';

List<CategoryModel> categorys=[

  CategoryModel(image: "assets/icons/pizza.png", title: 
  "Pizza"),
  CategoryModel(image: "assets/icons/burger.png", title: 
  "Burger"),
  CategoryModel(image: "assets/icons/sauage.png", title: 
  "Sauage"),
  CategoryModel(image: "assets/icons/samosa.png", title: 
  "Samosa"),
  
];

List<ProductModel> burgerList=[
  ProductModel(
    image: "assets/images/bigcheeseburger.png", 
    title:  "Big Cheese Burger", 
    description: "A large, hearty burger with extra cheese for a satisfyingly rich flavor.",
    price: 89),
    
  ProductModel(
    image: "assets/images/chesseburger.png", 
    title:  "Medium Cheese Burger", 
    description: "A classic, moderately sized burger featuring a perfect balance of cheese and savory toppings.",
    price: 79),
    
  ProductModel(
    image: "assets/images/hotdog.png", 
    title:  "Cutlet Burger", 
    description: "A savory burger featuring a crisp cutlet, offering a unique texture and flavor experience.",
    price: 69),
    
];

List<ProductModel> pizzaList=[
  ProductModel(image: "assets/images/chickenpizza.png", 
  title:  "Chicken Pizza", 
  description: "A savory pizza topped with tender chicken pieces, offering a hearty and flavorful experience.",
  price: 80),
  ProductModel(image: "assets/images/cheesepizza.png", 
  title:  "Cheese Pizza", 
  description: "A classic and simple pizza, featuring a generous layer of melted cheese for pure, cheesy delight.",
  price: 70),
  ProductModel(image: "assets/images/pizza.png", 
  title:  "Veg Pizza", 
  description: "A vibrant and flavorful pizza loaded with a variety of fresh vegetables, catering to vegetarian preferences.",
  price: 50),
];
List<ProductModel> sausageList=[
  ProductModel(image: "assets/images/juicyhotdog.png", 
  title:  "Juicy Sausage", 
  description: "A plump and succulent sausage, bursting with savory flavors in every bite.",
  price: 89),
  ProductModel(image: "assets/images/smokesausage.png", 
  title:  "Smoked Sausage", 
  description: "A richly flavored sausage, infused with a distinct smoky aroma for a robust taste.",
  price: 99),
  ProductModel(image: "assets/images/toppedsausage.png", 
  title:  "Topped Sausage", 
  description: "A creatively garnished sausage, featuring a variety of complementary toppings for an enhanced culinary experience.",
  price: 79),
];
List<ProductModel> samosaList=[
  ProductModel(image: "assets/images/paneersamosa.png", 
  title:  "Paneer Samosa", 
  description: "A savory pastry filled with spiced paneer, offering a rich and creamy vegetarian delight.",
  price: 25),
  ProductModel(image: "assets/images/samosa1.png", 
  title:  "Aloo Samosa", 
  description: "A classic pastry filled with spiced potatoes and peas, providing a comforting and hearty snack.",
  price: 20),
  ProductModel(image: "assets/images/onionsamosa.png", 
  title:  "Onion Samosa", 
  description: "A flavorful pastry filled with caramelized onions and spices, delivering a sweet and savory bite.",
  price: 15),
];
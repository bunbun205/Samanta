import 'dart:async';
import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:samanta/game/samanta.dart';
import 'package:samanta/gen/assets.gen.dart';

class InventoryDisplay extends PositionComponent with HasGameRef<Samanta> {
  InventoryDisplay({
    required super.scale,
    required super.position,
  }) : super(anchor: Anchor.centerLeft);

  late final SpriteComponent textbox;

  late final List<ButtonComponent> ingredientButtons;

  final Inventory inventory = Inventory();

  int counter = 0;

  final Menu menu = Menu();

  @override
  Future<void> onLoad() async {
    textbox = SpriteComponent.fromImage(gameRef.images.fromCache(Assets.images.shelf.path),);
    textbox.scale = Vector2(0.03, 0.03);
    textbox.position = Vector2(10, 15);

    ingredientButtons = List.empty(growable: true);

    for(int n = 0; n < inventory.ingredients.length; n++) {
      ingredientButtons.add(ButtonComponent(
        anchor: anchor,
        button: SpriteComponent(
          sprite: await Sprite.load('${inventory.ingredients[n].keys.first}.png'),
          scale: Vector2.all(0.25),
          priority: 1,
        ),
        position: Vector2(11 + 6.0 * n, 25),
        onPressed: () { print('pressed'); },
        priority: 1,
      ));

      add(ingredientButtons[n]);
    }

    await addAll([
      textbox,
    ]);
  }
}

class MenuDisplay extends PositionComponent with HasGameRef<Samanta> {
  MenuDisplay({
    required super.scale,
    required super.position,
  }) : super(anchor: Anchor.centerLeft);

  late final SpriteComponent textbox;

  late final TextBoxComponent text;

  int counter = 0;

  final Menu menu = Menu();

  @override
  Future<void> onLoad() async {
    textbox = SpriteComponent.fromImage(
        gameRef.images.fromCache(Assets.images.textbox.path),);
    textbox.scale = Vector2(0.05, 0.15);
    textbox.position = Vector2(40, -40);
    text = TextBoxComponent(
      anchor: anchor,
      text: menu.printMenu(),
      size: Vector2(textbox.size.x, textbox.size.y + 5),
      scale: Vector2.all(0.05),
      position: textbox.position + Vector2(0, 15),
      align: Anchor.topCenter,
      textRenderer:
          TextPaint(style: const TextStyle(fontSize: 55, color: Colors.black))
              .copyWith(
        (style) => style.copyWith(
          letterSpacing: 2,
        ),
      ),
    );

    await addAll([
      textbox,
      text,
    ]);
  }
}

class MenuItem {
  final String name;
  final double price;
  final List<String> ingredients; // List of required ingredients

  MenuItem({
    required this.name,
    required this.price,
    required this.ingredients,
  });

  @override
  String toString() {
    return '$name : \$$price';
  }
}

class Menu {
  final List<MenuItem> menuItems = [
    MenuItem(name: 'Burger', price: 300, ingredients: ['Bun', 'Patty', 'Lettuce', 'Tomato']),
    MenuItem(name: 'Fries', price: 100, ingredients: ['Potato', 'Salt']),
    MenuItem(name: 'Lemonade', price: 200, ingredients: ['Lemon', 'Sugar']),
  ];

  MenuItem? getItem(String name) {
    try {
      return menuItems.firstWhere((item) => item.name == name);
    } catch (e) {
      return null; // If item is not found, return null
    }
  }

  String printMenu() {
    var text = ' ';
    for (final item in menuItems) {
      text += item.toString().toUpperCase();
      text += '\n';
    }
    return text;
  }

  MenuItem randomItem() {
    final random = Random();
    final item = menuItems[random.nextInt(menuItems.length)];
    return item;
  }
}

class Inventory {
  // List of available ingredients with their quantities
  final List<Map<String, int>> ingredients = [
    {'patty': 10},
    {'bun': 15},
    {'lettuce': 20},
    {'tomato': 25},
    {'cheese': 30},
    {'potato': 50},
    {'lemon': 20},
    {'sugar': 40},
    {'salt' : 50}
  ];

  // Method to get the available quantity of an ingredient by name
  int? getIngredientQuantity(String name) {
    for (var ingredient in ingredients) {
      if (ingredient.containsKey(name)) {
        return ingredient[name];
      }
    }
    return null;
  }

  // Method to update the quantity of an ingredient
  void updateIngredientQuantity(String name, int quantity) {
    for (var ingredient in ingredients) {
      if (ingredient.containsKey(name)) {
        ingredient[name] = quantity;
        return;
      }
    }
  }

  // Method to decrease the quantity of an ingredient by 1
  bool useIngredient(String name) {
    for (var ingredient in ingredients) {
      if (ingredient.containsKey(name) && ingredient[name]! > 0) {
        ingredient[name] = ingredient[name]! - 1;
        return true; // Ingredient used successfully
      }
    }
    return false; // Ingredient not available or out of stock
  }

  // Check if the required ingredients are available
  bool areIngredientsAvailable(Map<String, int> requiredIngredients) {
    for (var entry in requiredIngredients.entries) {
      final availableQuantity = getIngredientQuantity(entry.key);
      if (availableQuantity == null || availableQuantity < entry.value) {
        return false; // Ingredient not available or not enough quantity
      }
    }
    return true;
  }

  // Print out the list of ingredients for display
  String printInventory() {
    var text = 'Available Ingredients:\n';
    for (var ingredient in ingredients) {
      text += '${ingredient.keys.first}: ${ingredient.values.first}\n';
    }
    return text;
  }
}


class Order {
  final Map<MenuItem, int> items = {};
  final Map<MenuItem, bool> completedItems = {};

  void addItem(MenuItem item) {
    if (items.containsKey(item)) {
      items[item] = items[item]! + 1;
    } else {
      items[item] = 1;
    }
    completedItems[item] = false; // Mark as not completed when added
  }

  void removeItem(MenuItem item) {
    if (items.containsKey(item) && items[item]! > 1) {
      items[item] = items[item]! - 1;
    } else {
      items.remove(item);
      completedItems.remove(item);
    }
  }

  void completeItem(MenuItem item) {
    if (completedItems.containsKey(item)) {
      completedItems[item] = true;
    }
  }

  bool isCompleted() {
    return completedItems.values.every((isCompleted) => isCompleted);
  }

  int totalItem() {
    return items.values.fold(0, (total, count) => total + count);
  }

  double getTotalPrice() {
    double total = 0;
    for (final item in items.entries) {
      total += item.key.price * item.value;
    }
    return total;
  }
}

<<<<<<< Updated upstream
class Customer extends SpriteComponent with 
HasGameRef<Samanta>, CollisionCallbacks {
=======

class Customer extends SpriteComponent 
  with HasGameRef<Samanta>, CollisionCallbacks {
  Customer() {
    // Assign random items to the order
    for (var i = 0; i < Random().nextInt(3) + 1; i++) {
      final randomItem = menu.randomItem();
      order.addItem(randomItem);
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other.runtimeType == Customer && other.position.x > position.x) {
      speed = 0;
      super.onCollisionStart(intersectionPoints, other);
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    speed = 100;
    super.onCollisionEnd(other);
  }


>>>>>>> Stashed changes
  final Order order = Order();
  bool gettingServed = false;
  double speed = 100;
  final Menu menu = Menu();

  late TextComponent orderDisplay;

<<<<<<< Updated upstream
  Customer() {
    for (int i = 0; i < Random().nextInt(3) + 1; i++) {
      order.addItem(menu.randomItem());
    }

   
    super.debugMode=true;
  }
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other.runtimeType==Customer && other.position.x>position.x){
      speed=0;
=======
  // Boolean flag to track if the customer is ready to be served
  bool isReadyToBeServed = false;
>>>>>>> Stashed changes

    }
    // TODO: implement onCollisionStart
    super.onCollisionStart(intersectionPoints, other);
  }
  @override
  void onCollisionEnd(PositionComponent other) {
    speed=100;
    // TODO: implement onCollisionEnd
    super.onCollisionEnd(other);
  }
  @override
  FutureOr<void> onLoad() {
<<<<<<< Updated upstream
    position=Vector2(-gameRef.size.x/2-10,gameRef.size.y/2);
    gameRef.numCustomers+=1;
    Random random = Random();
=======
    gameRef.numCustomers += 1;

    position = Vector2(-gameRef.size.x / 2 - size.x, gameRef.size.y / 2);
    final random = Random();
>>>>>>> Stashed changes
    sprite = gameRef.customerSprites[random.nextInt(gameRef.customerSprites.length)];

    orderDisplay = TextComponent(
      text: order.items.entries.toString(),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 24, color: Colors.black),
      ),
      position: position, // Position above the customer sprite
      anchor: anchor,
    );
<<<<<<< Updated upstream
    add(RectangleHitbox.relative(Vector2(1.2,1), parentSize: size));
    // add(orderDisplay);
=======

    add(RectangleHitbox.relative(Vector2(1.2, 1), parentSize: size));
>>>>>>> Stashed changes
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += speed * dt;

    // Stop customer at the counter when it's time to be served
    if (position.x >= gameRef.size.x / 2 && !gettingServed) {
      gettingServed = true;
      speed = 0; // Stop movement when getting served
    }

    // If all items are marked as completed, let the customer leave
    if (gettingServed && order.isCompleted()) {
      position.x += speed * dt;
      if (position.x > gameRef.size.x + 100) {
        removeFromParent();
<<<<<<< Updated upstream
        gameRef.numCustomers-=1;
=======
        gameRef.numCustomers -= 1;
>>>>>>> Stashed changes
      }
    }

    // Update the display position to follow the customer
    orderDisplay.position = position;
  }

  // Method to manually complete the order when the correct ingredients are selected
  void completeOrderItem(MenuItem item) {
    order.completeItem(item);

    // If all items are complete, move the customer
    if (order.isCompleted()) {
      speed = 100; // Resume movement
    }
  }
}

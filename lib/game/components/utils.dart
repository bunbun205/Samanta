import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:samanta/game/samanta.dart';
import 'package:samanta/gen/assets.gen.dart';

class MenuDisplay extends PositionComponent with HasGameRef<Samanta> {
  MenuDisplay({
    required super.scale,
    required super.position,
  }) : super(anchor: Anchor.centerLeft);

  late final SpriteComponent textbox;

  late final TextBoxComponent text;

  int counter = 0;

  final Menu menu = new Menu();

  @override
  Future<void> onLoad() async {
    textbox = SpriteComponent.fromImage(
        gameRef.images.fromCache(Assets.images.textbox.path));
    textbox.scale = Vector2(0.05, 0.15);
    textbox.position = Vector2(40, -40);
    print(textbox.size);
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

class Menu {
  final List<Map<String, double>> menu_items = [
    {'burger': 300},
    {'fries': 100},
    {'lemonade': 200},
  ];
  Map<String, double>? get_item(String Name) {
    for (var item in menu_items) {
      if (item.containsKey(Name)) {
        return item;
      }
    }
    return null;
  }

  String printMenu() {
    String text = " ";
    menu_items.forEach((item) {
      text += item.toString().toUpperCase();
      text += '\n';
    });

    return text;
  }

  String randomItem() {
    final random = Random();
    final item = menu_items[random.nextInt(menu_items.length)];
    return item.keys.first;
  }
}

class Order {
  final Map<String, int> items = {};
  final Map<String, bool> completedItems = {};
  void addItem(String Name) {
    if (items.containsKey(Name)) {
      items[Name] = items[Name]! + 1;
    } else {
      items[Name] = 1;
    }
  }

  void remove_item(String Name) {
    if (items.containsKey(Name) && items[Name]! > 1) {
      items[Name] = items[Name]! - 1;
    } else {
      items.remove(Name);
    }
  }

  void completeItem(String name) {
    if (completedItems.containsKey(name)) {
      completedItems[name] = true;
    }
  }

  bool isCompleted() {
    return completedItems.values.every((isCompleted) => isCompleted);
  }

  int totalItem() {
    return items.values.fold(0, (total, count) => total + count);
  }

  double getTotalPrice(Menu menu) {
    double total = 0;
    for (var item in items.entries) {
      var price = menu.get_item(item.key)?.values.first;
      // double price = menu.get_item(item.key)?.values.first ?? 0;
      total += price! * item.value;
    }
    return total;
  }
}

class Customer extends SpriteComponent with HasGameRef<Samanta> {
  final Order order = Order();
  bool gettingServed = false;
  double speed = 100;
  double totalWaitTime = 0;
  final Menu menu = Menu();

  late TextComponent orderDisplay;

  Customer() {
    for (int i = 0; i < Random().nextInt(3) + 1; i++) {
      order.addItem(menu.randomItem());
    }

    position = Vector2(-50, 400);
  }

  @override
  FutureOr<void> onLoad() {
    
    Random random = Random();
    sprite = gameRef.customerSprites[random.nextInt(gameRef.customerSprites.length)];

    orderDisplay = TextComponent(
      text: order.items.entries.toString(),
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 24, color: Colors.black),
      ),
      position: position,  // Position above the customer sprite
      anchor: anchor
    );

    // add(orderDisplay);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += speed * dt;

    if (position.x >= 500 && !gettingServed) {
      gettingServed = true;
      speed = 0;
      prepareOrder();
    }


    if (gettingServed && order.isCompleted()) {
      position.x += speed * dt;
      if (position.x > gameRef.size.x + 100) {
        removeFromParent();
      }
    }
    orderDisplay.position = position;
  }

  double getTotalPrice(Menu menu) {
    return order.getTotalPrice(menu);
  }

  void prepareOrder() async {
    for (var item in order.items.entries) {
      await Future.delayed(Duration(
        seconds: menu.get_item(item.key)?['burger'] == 300.00
            ? 3
            : menu.get_item(item.key)?['fries'] == 100.00
                ? 5
                : 7,
      ));

      order.completeItem(item.key);
    }

    double total = getTotalPrice(menu);
    game.totalEarnings += total;
    speed = 100;
  }
}


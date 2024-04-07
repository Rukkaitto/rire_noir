import 'dart:convert';
import 'dart:io';

import 'package:api/entities/card.dart';

class CardLoader {
  static List<Map<String, dynamic>> getJsonList({required String path}) {
    final file = File(path);
    final json = jsonDecode(file.readAsStringSync());
    return List<Map<String, dynamic>>.from(json);
  }

  static List<Card> loadCards({required String path}) {
    // Get black cards from json
    final jsonList = CardLoader.getJsonList(path: path);

    // Convert json to Card objects
    final cards = jsonList.map((json) => Card.fromJson(json)).toList();

    // Shuffle the cards
    cards.shuffle();

    return cards;
  }
}

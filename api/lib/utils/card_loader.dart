import 'dart:convert';
import 'dart:io';

import 'package:api/entities/playing_card.dart';

class CardLoader {
  static List<Map<String, dynamic>> getJsonList({required String path}) {
    final file = File(path);
    final json = jsonDecode(file.readAsStringSync());
    return List<Map<String, dynamic>>.from(json);
  }

  static List<PlayingCard> loadCards({required String path}) {
    // Get black cards from json
    final jsonList = CardLoader.getJsonList(path: path);

    // Convert json to PlayingCard objects
    final cards = jsonList.map((json) => PlayingCard.fromJson(json)).toList();

    // Shuffle the cards
    cards.shuffle();

    return cards;
  }
}

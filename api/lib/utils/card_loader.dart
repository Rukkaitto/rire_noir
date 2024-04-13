import 'dart:convert';
import 'dart:io';

import 'package:api/entities/playing_card.dart';

class CardLoader {
  static List<T> getJsonList<T>({required String path}) {
    final file = File(path);
    final json = jsonDecode(file.readAsStringSync());
    return List<T>.from(json);
  }

  static List<PlayingCard> loadCards({required String path}) {
    // Get black cards from json
    final cardContents = CardLoader.getJsonList<String>(path: path);

    // Convert json to PlayingCard objects
    final cards = cardContents.asMap().entries.map((entry) {
      final id = entry.key;
      final text = entry.value;

      return PlayingCard(
        id: id,
        text: text,
      );
    }).toList();

    // Shuffle the cards
    cards.shuffle();

    return cards;
  }
}

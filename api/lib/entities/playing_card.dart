class PlayingCard {
  final int id;
  final String text;
  String? playerId;

  String get formattedText => text.replaceAll('%@', '_____');
  int get requiredWhiteCardCount => text.split('%@').length - 1;

  PlayingCard({
    required this.id,
    required this.text,
    this.playerId,
  });

  factory PlayingCard.fromJson(Map<String, dynamic> json) {
    return PlayingCard(
      id: json['id'],
      text: json['text'],
      playerId: json['playerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'playerId': playerId,
    };
  }
}

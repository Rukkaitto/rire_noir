class Card {
  final int id;
  final String text;

  Card({required this.id, required this.text});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}

import 'package:api/entities/player.dart';

class PlayerWithScore {
  final Player player;
  final int score;

  PlayerWithScore(this.player, this.score);

  Map<String, dynamic> toJson() {
    return {
      'player': player.toJson(),
      'score': score,
    };
  }

  factory PlayerWithScore.fromJson(Map<String, dynamic> json) {
    return PlayerWithScore(
      Player.fromJson(json['player']),
      json['score'],
    );
  }
}

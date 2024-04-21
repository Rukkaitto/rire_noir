/// An event that is sent from the server to the client
enum ServerEvent {
  /// Sent to all players when a new player joins the room or when a player
  /// is ready. Data contains the number of ready players and total players
  readyPlayersCountChanged,

  /// Sent to the master player when a player sends a selectCard event.
  roundDonePlayersCountChanged,

  /// Sent to the winner player when the master sends a selectWinner event.
  /// Data contains the winner's new score
  playerWonRound,

  /// Sent to loser players when the master sends a selectWinner event
  playerLostRound,

  /// Send to a player when new cards are dealt
  /// Data contains the player's new cards
  newCardsDealt,

  /// Sent to the game's winner when the game ends.
  playerWonGame,

  /// Sent to the game's losers when the game ends.
  playerLostGame,
}

extension ServerEventExtension on ServerEvent {
  static ServerEvent fromJson(String event) {
    switch (event) {
      case 'readyPlayersCountChanged':
        return ServerEvent.readyPlayersCountChanged;
      case 'roundDonePlayersCountChanged':
        return ServerEvent.roundDonePlayersCountChanged;
      case 'playerWonRound':
        return ServerEvent.playerWonRound;
      case 'playerLostRound':
        return ServerEvent.playerLostRound;
      case 'newCardsDealt':
        return ServerEvent.newCardsDealt;
      case 'playerWonGame':
        return ServerEvent.playerWonGame;
      case 'playerLostGame':
        return ServerEvent.playerLostGame;
      default:
        throw Exception('Event $event not found');
    }
  }

  String toJson() {
    switch (this) {
      case ServerEvent.readyPlayersCountChanged:
        return 'readyPlayersCountChanged';
      case ServerEvent.roundDonePlayersCountChanged:
        return 'roundDonePlayersCountChanged';
      case ServerEvent.playerWonRound:
        return 'playerWonRound';
      case ServerEvent.playerLostRound:
        return 'playerLostRound';
      case ServerEvent.newCardsDealt:
        return 'newCardsDealt';
      case ServerEvent.playerWonGame:
        return 'playerWonGame';
      case ServerEvent.playerLostGame:
        return 'playerLostGame';
    }
  }
}

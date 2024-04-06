import 'dart:convert';

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/ws'));
  Map<String, dynamic> data = {
    'event': 'createRoom',
    'data': {
      'capacity': 4,
      'winningScore': 10,
    }
  };
  channel.sink.add(jsonEncode(data));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292D30),
      body: Center(
        child: SizedBox(
          width: 310,
          height: 480,
          child: AppinioSwiper(
            swipeOptions:
                const SwipeOptions.only(left: true, up: true, right: true),
            loop: true,
            cardCount: 11,
            cardBuilder: (BuildContext context, int index) {
              return PlayingCard(
                title: 'Card $index',
                style: index % 2 == 0
                    ? const PlayingCardStyleWhite()
                    : const PlayingCardStyleBlack(),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  final game = MyGame();
  runApp(
    GameWidget(game: game)
  );
}

class MyGame extends Game with TapDetector {

  final robotPosition = Vector2(240, 50);
  final robotSize = Vector2(48, 60);

  SpriteAnimation runningRobot;

  Sprite pressedButton;
  Sprite unpressedButton;
  final buttonPosition = Vector2(200, 120);
  final buttonSize = Vector2(120, 30);
  bool isPressed = false;

  @override
  Future<void> onLoad() async {
    runningRobot = await loadSpriteAnimation(
      'robot.png',
      SpriteAnimationData.sequenced(
        amount: 8,
        textureSize: Vector2(16, 18),
        stepTime: 0.1,
      ),
    );

    unpressedButton = await loadSprite(
      'buttons.png',
      srcPosition: Vector2.zero(), // this is zero by default
      srcSize: Vector2(60, 20),
    );

    pressedButton = await loadSprite(
      'buttons.png',
      srcPosition: Vector2(0, 20),
      srcSize: Vector2(60, 20),
    );
  }

  @override
  void render(Canvas canvas) {
    runningRobot
        .getSprite()
        .render(canvas, position: robotPosition, size: robotSize);

    final button = isPressed ? pressedButton : unpressedButton;
    button.render(canvas, position: buttonPosition, size: buttonSize);
  }

  @override
  void update(double dt) {
    runningRobot.update(dt);
    if (isPressed) {
      runningRobot.update(dt);
    }
  }

  @override
  void onTapDown(TapDownDetails details) {
    final buttonArea = buttonPosition & buttonSize;
    isPressed = buttonArea.contains(details.localPosition);
  }

  @override
  void onTapUp(TapUpDetails details) {
    isPressed = false;
  }

  @override
  void onTapCancel() {
    isPressed = false;
  }


  @override
  Color backgroundColor() => const Color(0xFF222222);
}

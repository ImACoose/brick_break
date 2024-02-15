import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart'; // Add this import
import 'package:flame/game.dart';
import 'package:flutter/material.dart'; // And this import
import 'package:flutter/services.dart'; // And this

import 'components/components.dart';
import 'config.dart';

class BrickBreak extends FlameGame with HasCollisionDetection, KeyboardEvents {
  BrickBreak()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  final random = math.Random();
  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    world.add(Ball(
        velocity: Vector2((random.nextDouble() - 0.5) * width, height * 0.2)
            .normalized()
          ..scale(height / 4),
        position: size / 2,
        radius: ballWidth));

    world.add(Bat(
        cornerRadius: const Radius.circular(ballWidth / 2),
        position: Vector2(width / 2, height * 0.95),
        size: Vector2(batWidth, batHeight)));

    debugMode = true;
  }

  @override // Add from here...
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(batStep);
    }
    return KeyEventResult.handled;
  } // To here
}

import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/components.dart';
import 'config.dart';

class BrickBreak extends FlameGame with HasCollisionDetection {
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

    debugMode = true;
  }
}

import 'package:brick_break/src/brick_break.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'play_area.dart';
import 'bat.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<BrickBreak> {
  final Vector2 velocity;

  Ball({
    required this.velocity,
    required super.position,
    required double radius,
  }) : super(
            children: [CircleHitbox()],
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill);

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        add(RemoveEffect(
          // Modify from here...
          delay: 0.35,
        ));
      }
      } else if (other is Bat) {
        velocity.y = -velocity.y;
        velocity.x = velocity.x +
            (position.x - other.position.x) / other.size.x * game.width * 0.3;
      } else {
        debugPrint('collision with $other');
      }
    }
  }

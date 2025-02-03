import 'package:flutter/material.dart';

class RouteTransition {
  static PageRouteBuilder easeIn({required Widget child}) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeIn;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        });
  }

  static PageRouteBuilder fadeIn({required Widget child}) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final _opacity = animation.drive(Tween<double>(begin: 0, end: 1)
              .chain(CurveTween(curve: Curves.easeIn)));
          return FadeTransition(opacity: _opacity, child: child);
        });
  }
}

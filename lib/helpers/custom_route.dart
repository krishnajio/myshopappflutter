import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,

    Widget child,
  ) {
    //if (settings.isIntialRoute) {
    //return child;
    //}
   return RotationTransition(
     turns: Tween<double>(
       begin: 0.0,
       end: 1.0,
     ).animate(
       CurvedAnimation(
         parent: animation,
         curve: Curves.linear,
       ),
     ),
      child: child,
    );
  }
}


class CustomPageTransitionBuilder extends PageTransitionsBuilder{

  @override
  Widget buildTransitions<T>(
      PageRoute route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    //if (settings.isIntialRoute) {
    //return child;
    //}

   return SizeTransition(
      sizeFactor: animation,
      child: child,
    );
  }

}




import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class CustomTab extends StatefulWidget {
  final String title;
  final String body;
  final Color backgroundColor;
  final IconData iconData;
  final bool flip;
  final clipper;
  final bool middle;

  const CustomTab({
    Key key,
    this.iconData,
    this.title,
    this.middle = false,
    this.body,
    this.flip = false,
    this.clipper,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation growAnimation;
  double notificationExtent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);

    growAnimation = Tween(begin: 0.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceInOut,
        reverseCurve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        print(notification.extent);
        setState(() {
          notificationExtent = notification.extent;
          if (notificationExtent == .6) {
            _animationController.forward();
          } else
            _animationController.reverse();
        });
        return true;
      },
      child: SizedBox.expand(
        child: DraggableScrollableSheet(
          initialChildSize: .13,
          minChildSize: .13,
          maxChildSize: .6,
          builder: (context, controller) => ClipPath(
            clipper: widget.clipper,
            clipBehavior: Clip.hardEdge,
            child: Container(
              color: widget.backgroundColor,
              child: ListView(
                physics: BouncingScrollPhysics(),
                controller: controller,
                children: <Widget>[
                  Container(
                    color: widget.backgroundColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: this.widget.middle? double.infinity: MediaQuery.of(context).size.width / 4,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                this.widget.iconData,
                                color: Colors.white,
                                size: 30,
                              ),
                              notificationExtent == 0.6
                                  ? Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 14,
                                        ),
                                        ScaleTransition(
                                          scale: growAnimation,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                        SizedBox(height: 72),
                        Transform(
                          transform: this.widget.flip
                              ? (Matrix4.rotationY(180 * pi / 180)
                                ..translate(
                                  -1 * (MediaQuery.of(context).size.width - 36),
                                ))
                              : Matrix4.rotationY(0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 40,
                                  color: TinyColor(widget.backgroundColor)
                                      .darken(20)
                                      .color,
                                ),
                              ),
                              SizedBox(
                                height: 36,
                              ),
                              Text(
                                widget.body,
                                style: TextStyle(
                                  fontSize: 28,
                                  color: TinyColor(widget.backgroundColor)
                                      .darken(20)
                                      .color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

const Duration _kMenuDuration = Duration(milliseconds: 300);
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
const double _kMenuHorizontalPadding = 16.0;
const double _kMenuDividerHeight = 16.0;
const double _kMenuMaxWidth = 5.0 * _kMenuWidthStep;
const double _kMenuMinWidth = 2.0 * _kMenuWidthStep;
const double _kMenuVerticalPadding = 8.0;
const double _kMenuWidthStep = 56.0;
const double _kMenuScreenPadding = 8.0;

typedef PopupConfirm = void Function();

typedef PopupCancel = void Function();

class PopupWrapper extends StatefulWidget {
  PopupWrapper({
    Key key,
    @required this.child,
    @required this.popupView,
    this.onConfirm,
    this.onCancel,
    this.padding = EdgeInsets.zero,
    this.elevation,
    this.shape,
    this.color,
    this.tooltip,
    this.offset = Offset.zero,
    this.enabled = true,
  }) : super(key: key);

  final Widget child;
  final Widget popupView;
  final PopupConfirm onConfirm;
  final PopupCancel onCancel;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final ShapeBorder shape;
  final Color color;
  final String tooltip;
  final Offset offset;
  final bool enabled;

  @override
  _PopupWrapperState createState() => _PopupWrapperState();
}

class _PopupWrapperState extends State<PopupWrapper> {
  void showPopup() {
    final RenderBox child = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    print('${child.localToGlobal(Offset.zero)}');
    print('${overlay.localToGlobal(Offset.zero)}');
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        child.localToGlobal(widget.offset, ancestor: overlay),
        child.localToGlobal(child.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    Navigator.of(context)
        .push(_PopupWrapRoute(
          position: position,
          child: widget.popupView,
        ))
        .then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    Widget target = InkWell(
      onTap: widget.enabled ? showPopup : null,
      canRequestFocus: widget.enabled,
      child: widget.child,
    );
    if (widget.tooltip != null) {
      target = Tooltip(
        message: widget.tooltip ?? '',
        child: target,
      );
    }
    return target;
  }
}

class _PopupWrapRoute extends PopupRoute {
  _PopupWrapRoute({
    Key key,
    this.position,
    @required this.child,
  });

  final RelativeRect position;

  final Widget child;

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String barrierLabel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd),
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    print('$position');
    return MediaQuery.removePadding(
      context: context,
      removeLeft: true,
      removeRight: true,
      removeTop: true,
      removeBottom: true,
      child: Builder(builder: (context) {
        return CustomSingleChildLayout(
          delegate: _PopupWrapRouteLayout(
            position: position,
            textDirection: Directionality.of(context),
          ),
          child: child,
        );
      }),
    );
  }
}

class _PopupWrapRouteLayout extends SingleChildLayoutDelegate {
  _PopupWrapRouteLayout({
    this.position,
    this.textDirection,
  });

  final RelativeRect position;
  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(
      constraints.biggest -
          const Offset(
            _kMenuScreenPadding * 2.0,
            _kMenuScreenPadding * 2.0,
          ) as Size,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    double y = position.top;

    // Find the ideal horizontal position.
    double x;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    } else {
      // Menu button is equidistant from both edges, so grow in reading direction.
      assert(textDirection != null);
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // Avoid going outside an area defined as the rectangle 8.0 pixels from the
    // edge of the screen in every direction.
    if (x < _kMenuScreenPadding)
      x = _kMenuScreenPadding;
    else if (x + childSize.width > size.width - _kMenuScreenPadding)
      x = size.width - childSize.width - _kMenuScreenPadding;
    if (y < _kMenuScreenPadding)
      y = _kMenuScreenPadding;
    else if (y + childSize.height > size.height - _kMenuScreenPadding)
      y = size.height - childSize.height - _kMenuScreenPadding;
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupWrapRouteLayout oldDelegate) {
    return position != oldDelegate.position ||
        textDirection != oldDelegate.textDirection;
  }
}

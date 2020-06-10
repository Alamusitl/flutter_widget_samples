import 'package:flutter/material.dart';

const Duration _kDuration = Duration(milliseconds: 300);
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
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
    this.elevation = 8.0,
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
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    print(child.localToGlobal(widget.offset, ancestor: overlay));
    print(child.localToGlobal(child.size.bottomRight(Offset.zero), ancestor: overlay));
    print('${child.size}');
    print('${overlay.size}');
    print('${Rect.fromPoints(
      child.localToGlobal(widget.offset, ancestor: overlay),
      child.localToGlobal(child.size.bottomRight(Offset.zero), ancestor: overlay),
    )}');
    print('${Offset.zero & overlay.size}');
    RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        child.localToGlobal(widget.offset, ancestor: overlay),
        child.localToGlobal(child.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    print('$position');
    double childY = child.localToGlobal(widget.offset, ancestor: overlay).dy;
    position = RelativeRect.fromLTRB(
      0.0,
      childY + child.size.height,
      overlay.size.width,
      overlay.size.height,
    );
    print('$position');
    Widget popupChild = Card(
      color: widget.color,
      shape: widget.shape,
      elevation: widget.elevation,
      margin: widget.padding,
      child: widget.popupView,
    );
    Navigator.of(context)
        .push(_PopupWrapRoute(
          position: position,
          child: popupChild,
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
    @required this.position,
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
  Duration get transitionDuration => _kDuration;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd),
    );
  }

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return SingleChildScrollView(
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
          Offset(
            0.0,
            position.top,
          ) as Size,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // Find the ideal vertical & horizontal position.
    double x = position.left;
    double y = position.top;

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupWrapRouteLayout oldDelegate) {
    return position != oldDelegate.position || textDirection != oldDelegate.textDirection;
  }
}

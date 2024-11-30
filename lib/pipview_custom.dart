import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';

import 'rawpipview_custom.dart' as Custom;

void dismissKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

class PIPViewCustom extends StatefulWidget {
  final Custom.PIPViewCorner initialCorner;
  final double? floatingWidth;
  final double? floatingHeight;
  final bool avoidKeyboard;

  final Widget Function(
    BuildContext context,
    bool isFloating,
  ) builder;

  const PIPViewCustom({
    Key? key,
    required this.builder,
    this.initialCorner = Custom.PIPViewCorner.topRight,
    this.floatingWidth,
    this.floatingHeight,
    this.avoidKeyboard = true,
  }) : super(key: key);

  @override
  PIPViewCustomState createState() => PIPViewCustomState();

  static PIPViewCustomState? of(BuildContext context) {
    return context.findAncestorStateOfType<PIPViewCustomState>();
  }
}

class PIPViewCustomState extends State<PIPViewCustom>
    with TickerProviderStateMixin {
  Widget? _bottomWidget;

  void presentBelow(Widget widget, BuildContext backgroundPageContext) {
    dismissKeyboard(context);

    // Navigator.of(backgroundPageContext).pop();
    setState(() => _bottomWidget = widget);
  }

  void stopFloating() {
    dismissKeyboard(context);
    setState(() => _bottomWidget = null);
  }

  @override
  Widget build(BuildContext context) {
    final isFloating = _bottomWidget != null;
    return Custom.RawPIPView(
      avoidKeyboard: widget.avoidKeyboard,
      bottomWidget: isFloating
          // ? _bottomWidget
          ? Navigator(
              onGenerateInitialRoutes: (navigator, initialRoute) => [
                MaterialPageRoute(builder: (context) => _bottomWidget!),
              ],
            )
          : null,
      onTapTopWidget: isFloating ? stopFloating : null,
      topWidget: IgnorePointer(
        // ignoring: isFloating,
        ignoring: false,

        // child: Container(
        //   child: Stack(
        //     children: [
        //       Builder(
        //         builder: (context) => widget.builder(context, isFloating),
        //       ),
        //       Positioned(
        //         child: IconButton(icon: Icon(Icons.close), onPressed: () => {}),
        //         top: 0,
        //       )
        //     ],
        //   ),
        // ),
        child: Builder(
          builder: (context) => widget.builder(context, isFloating),
        ),
      ),
      floatingHeight: widget.floatingHeight,
      floatingWidth: widget.floatingWidth,
      initialCorner: widget.initialCorner,
    );
  }
}

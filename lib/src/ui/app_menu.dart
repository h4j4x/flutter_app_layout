import 'package:flutter/material.dart';

import '../model/app_route.dart';
import '../model/event.dart';

class AppMenu extends StatefulWidget {
  final String? initialRoute;
  final double width;
  final BoxDecoration? decoration;
  final Widget? title;
  final AppRoutes routes;

  const AppMenu({
    super.key,
    this.initialRoute,
    required this.width,
    this.decoration,
    this.title,
    required this.routes,
  });

  @override
  State<StatefulWidget> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu>
    implements EventListener<NavigationEvent> {
  late String activePath;
  var expanded = true;

  @override
  void initState() {
    super.initState();
    activePath = widget.initialRoute ?? '/';
    Future.delayed(Duration.zero, () {
      NavigationEventPublisher().addListener(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: expanded ? widget.width : 58,
        decoration: widget.decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              leading: expanded ? toggleMenu() : null,
              title: expanded ? widget.title : toggleMenu(),
              backgroundColor: Colors.transparent,
              elevation: .0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.routes.length,
                itemBuilder: (context, index) {
                  return routeItem(widget.routes.getRouteAtIndex(index)!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget routeItem(AppRoute route) {
    return ListTile(
      leading: route.icon ??
          Icon(
            Icons.navigate_next_sharp,
            color: expanded ? Colors.transparent : null,
          ),
      title: expanded ? route.title : null,
      onTap: activePath != route.path
          ? () {
              NavigationEventPublisher().add(NavigationEvent.pending(route));
            }
          : null,
    );
  }

  Widget toggleMenu() {
    return InkWell(
      child: const Icon(Icons.menu_sharp),
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
    );
  }

  @override
  void onEvent(NavigationEvent event) {
    if (event.done) {
      activePath = event.route.path;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    NavigationEventPublisher().removeListener(this);
    super.dispose();
  }
}

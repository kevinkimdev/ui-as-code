@override
Widget build(BuildContext context) {
  return _ModalScopeStatus(
    route: widget.route,
    isCurrent: widget.route.isCurrent, // _routeSetState is called if this updates
    canPop: widget.route.canPop, // _routeSetState is called if this updates
    Offstage(
      offstage: widget.route.offstage, // _routeSetState is called if this updates
      PageStorage(
        bucket: widget.route._storageBucket, // immutable
        FocusScope(
          node: widget.route.focusScopeNode, // immutable
          RepaintBoundary(
            AnimatedBuilder(
              animation: _listenable, // immutable
              builder: (BuildContext context, Widget child) {
                return widget.route.buildTransitions(
                  context,
                  widget.route.animation,
                  widget.route.secondaryAnimation,
                  IgnorePointer(
                    ignoring: widget.route.animation?.status == AnimationStatus.reverse,
                    child,
                  ),
                );
              },
              _page ??= RepaintBoundary(
                key: widget.route._subtreeKey, // immutable
                Builder(
                  builder: (BuildContext context) {
                    return widget.route.buildPage(
                      context,
                      widget.route.animation,
                      widget.route.secondaryAnimation,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

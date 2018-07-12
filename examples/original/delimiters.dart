Widget build(BuildContext context) {
  return CupertinoTabScaffold(
    tabBuilder: (context, int index) {
      return CupertinoTabView(
        builder: (context) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Page 1 of tab $index'),
            ),
            child: Center(
              child: CupertinoButton(
                child: const Text('Next page'),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute<Null>(
                      builder: (context) {
                        return CupertinoPageScaffold(
                          navigationBar: CupertinoNavigationBar(
                            middle: Text('Page 2 of tab $index'),
                          ),
                          child: Center(
                            child: CupertinoButton(
                              child: const Text('Back'),
                              onPressed: () { Navigator.of(context).pop(); },
                            ), // Center
                          ), // CupertinoPageScaffold
                        );
                      },
                    ), // CupertinoPageRoute
                  ); // push
                },
              ), // CupertinoButton
            ), // Center
          ); // CupertinoPageScaffold
        },
      ); // CupertinoTabView
    },
  ); // CupertinoTabScaffold
}

// Some of this nested is unneeded because it's coming from builder functions.
// Hoisting those gives:
Widget build(BuildContext context) {
  buildPageRoute(BuildContext context) =>
    CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Page 2 of tab $index'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('Back'),
          onPressed: () { Navigator.of(context).pop(); },
        ), // Center
      ), // CupertinoPageScaffold
    );

  buildTabView(BuildContext context) =>
    CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Page 1 of tab $index'),
      ),
      child: Center(
        child: CupertinoButton(
          child: const Text('Next page'),
          onPressed: () {
            Navigator.of(context).push(
              CupertinoPageRoute<Null>(
                builder: buildPageRoute,
              ), // CupertinoPageRoute
            ); // push
          },
        ), // CupertinoButton
      ), // Center
    ); // CupertinoPageScaffold

  return CupertinoTabScaffold(
    tabBuilder: (BuildContext context, int index) {
      return CupertinoTabView(builder: buildTagView);
    },
  ); // CupertinoTabScaffold
}
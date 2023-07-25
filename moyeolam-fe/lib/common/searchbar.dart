import 'package:flutter/material.dart';
import 'package:youngjun/ui/common/const/colors.dart';


class PinnedSearchBarApp extends StatefulWidget {
  const PinnedSearchBarApp({super.key});

  @override
  State<PinnedSearchBarApp> createState() => _PinnedSearchBarAppState();
}

class _PinnedSearchBarAppState extends State<PinnedSearchBarApp> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: MAIN_COLOR),
        home: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[

                SliverAppBar(

                  clipBehavior: Clip.none,
                  shape: const StadiumBorder(),
                  scrolledUnderElevation: 0.0,
                  titleSpacing: 0.0,
                  backgroundColor: BACKGROUND_COLOR,
                  floating:
                  true, // We can also uncomment this line and set `pinned` to true to see a pinned search bar.
                  title: SearchAnchor.bar(
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      return List<Widget>.generate(
                        5,
                            (int index) {
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text('Initial list item $index'),
                          );
                        },
                      );
                    },
                  ),
                ),
                // The listed items below are just for filling the screen

              ],
            ),
          ),
        ),
      ),
    );
  }
}

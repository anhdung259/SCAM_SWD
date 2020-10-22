import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ShowMore extends StatefulWidget {
  final String text;
  final String title;

  const ShowMore({Key key, this.text, this.title}) : super(key: key);
  @override
  _ShowMoreState createState() => _ShowMoreState(text, title);
}

class _ShowMoreState extends State<ShowMore> {
  final String description;
  final String title;

  _ShowMoreState(this.description, this.title);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(1),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                collapsed: Text(
                  description,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var _ in Iterable.generate(1))
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          description,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

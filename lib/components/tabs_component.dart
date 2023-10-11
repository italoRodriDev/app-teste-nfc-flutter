import 'package:flutter/material.dart';

class TabsComponent extends StatefulWidget {
  final List<String> titlesTabs;
  final List<Widget> contentTabs;
  final Color colorTab;
  final Function onChangeIndex;
  final Function onChangeTitle;

  const TabsComponent(
      {Key? key,
      required this.colorTab,
      required this.titlesTabs,
      required this.contentTabs,
      required this.onChangeIndex,
      required this.onChangeTitle})
      : super(key: key);

  @override
  _TabsComponentState createState() => _TabsComponentState();
}

class _TabsComponentState extends State<TabsComponent> {
  late int tabIndex;

  @override
  void initState() {
    super.initState();
    tabIndex = 0;
  }

  setTabIndex(int value) {
    setState(() {
      tabIndex = value;
      widget.onChangeIndex(value);
      setTabTitle(value);
    });
  }

  setTabTitle(int indexTabs) {
    setState(() {
      String title = widget.titlesTabs[indexTabs];
      widget.onChangeTitle(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Column(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Center(
                      child: TextTabs(
                        colorTab: widget.colorTab,
                        labels: widget.titlesTabs,
                        onTabChange: setTabIndex,
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 20),
            widget.contentTabs[tabIndex],
          ],
        ),
      ),
    );
  }
}

class TextTabs extends StatefulWidget {
  const TextTabs(
      {required this.labels,
      this.onTabChange,
      required this.colorTab,
      Key? key})
      : super(key: key);
  final Color colorTab;
  final List<String> labels;
  final Function(int)? onTabChange;

  @override
  _TextTabsState createState() => _TextTabsState();
}

class _TextTabsState extends State<TextTabs> {
  late int selectedIndex;
  late String selectedTitle;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  callback() {
    if (widget.onTabChange != null) widget.onTabChange!(selectedIndex);
  }

  setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
    callback();
  }

  Widget _buildIndividualTab({required String label, Function()? onTap}) {
    int indexOfLabel = widget.labels.indexOf(label);
    bool isActive = selectedIndex == indexOfLabel;

    return GestureDetector(
      onTap: () {
        setSelectedIndex(indexOfLabel);
      },
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          border: isActive
              ? Border(
                  bottom: BorderSide(
                    color: widget.colorTab,
                    width: 2,
                  ),
                )
              : null,
        ),
        child: Text(
          (label.length > 17) ? (label.substring(0, 17) + '...') : label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? widget.colorTab : Colors.black.withOpacity(.6),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTextTabs() {
    return widget.labels.map((label) {
      return _buildIndividualTab(
          label: label,
          onTap: () {
            setSelectedIndex(widget.labels.indexOf(label));
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: intersperse(
            const SizedBox(width: 20),
            _buildTextTabs(),
          ).toList(),
        ),
        const Divider(height: 0, thickness: 1),
      ],
    );
  }
}

Iterable<T> intersperse<T>(T element, Iterable<T> iterable) sync* {
  final iterator = iterable.iterator;
  if (iterator.moveNext()) {
    yield iterator.current;
    while (iterator.moveNext()) {
      yield element;
      yield iterator.current;
    }
  }
}

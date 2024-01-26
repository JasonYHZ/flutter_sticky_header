import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class DoubleSliverCenterSideHeaderExample extends StatefulWidget {
  DoubleSliverCenterSideHeaderExample({
    Key? key,
  }) : super(key: key);

  @override
  State<DoubleSliverCenterSideHeaderExample> createState() =>
      _DoubleSliverCenterSideHeaderExampleState();
}

class _DoubleSliverCenterSideHeaderExampleState
    extends State<DoubleSliverCenterSideHeaderExample> {
  final centerKey = GlobalKey();
  int pinnedHeaderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Double Sliver Center Side Header Example'),
        ),
        body: CustomScrollView(
          center: centerKey,
          slivers: [
            _StickyHeaderGrid(
                index: -4, reverse: true, onHeaderPinned: onHeaderPinned),
            _StickyHeaderGrid(
                index: -3, reverse: true, onHeaderPinned: onHeaderPinned),
            _StickyHeaderGrid(
                index: -2, reverse: true, onHeaderPinned: onHeaderPinned),
            _StickyHeaderGrid(
                index: -1, reverse: true, onHeaderPinned: onHeaderPinned),
            SliverPadding(
              padding: EdgeInsets.zero,
              key: centerKey,
            ),
            _StickyHeaderGrid(index: 1, onHeaderPinned: onHeaderPinned),
            _StickyHeaderGrid(index: 2, onHeaderPinned: onHeaderPinned),
            _StickyHeaderGrid(index: 3, onHeaderPinned: onHeaderPinned),
            _StickyHeaderGrid(index: 4, onHeaderPinned: onHeaderPinned),
            _StickyHeaderGrid(index: 5, onHeaderPinned: onHeaderPinned),
          ],
        ),
      ),
    );
  }

  void onHeaderPinned(int index) {
    setState(() {
      pinnedHeaderIndex = index;
    });
  }
}

class _StickyHeaderGrid extends StatelessWidget {
  const _StickyHeaderGrid({
    Key? key,
    this.index,
    this.reverse = false,
    required this.onHeaderPinned,
  }) : super(key: key);

  final int? index;
  final bool reverse;
  final void Function(int index) onHeaderPinned;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      activityHandler: (activity) {
        debugPrint("[Header#$index] $activity");

        if (activity == SliverStickyHeaderActivity.pinned) {
          onHeaderPinned(index!);
        }
      },
      reverse: reverse,
      overlapsContent: true,
      header: _SideHeader(index: index),
      sliver: SliverPadding(
        padding: const EdgeInsets.only(left: 60),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
          delegate: SliverChildBuilderDelegate(
            (context, i) => GridTile(
              child: Card(
                    child: Container(
                      color: Colors.green,
                    ),
                  ),
                  footer: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Grid tile #$i',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
            childCount: 9,
          ),
        ),
      ),
    );
  }
}

class _SideHeader extends StatelessWidget {
  const _SideHeader({
    Key? key,
    this.index,
  }) : super(key: key);

  final int? index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 44.0,
          width: 44.0,
          child: CircleAvatar(
            backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.white,
            child: Text('$index'),
          ),
        ),
      ),
    );
  }
}

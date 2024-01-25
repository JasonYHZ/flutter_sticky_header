import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../common.dart';

class DoubleSliverCenterSideHeaderExample extends StatelessWidget {
   DoubleSliverCenterSideHeaderExample({
    Key? key,
  }) : super(key: key);


  final centerKey = GlobalKey();

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



            _StickyHeaderGrid(index: -4,reverse: true,),
            _StickyHeaderGrid(index: -3,reverse: true,),
            _StickyHeaderGrid(index: -2,reverse: true,),
            _StickyHeaderGrid(index: -1,reverse: true,),

            SliverPadding(
              padding: EdgeInsets.zero,
              key: centerKey,
            ),
            _StickyHeaderGrid(index: 0),
            _StickyHeaderGrid(index: 1),
            _StickyHeaderGrid(index: 2),
            _StickyHeaderGrid(index: 3),
          ],
        ),

      ),
    );





  }
}

class _StickyHeaderGrid extends StatelessWidget {
  const _StickyHeaderGrid({
    Key? key,
    this.index,
    this.reverse = false,
  }) : super(key: key);

  final int? index;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
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

import 'package:corwey_flutter/items/Item.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({
    @required this.isInTabletLayout,
    @required this.item,
  });

  final bool isInTabletLayout;
  final Item item;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          item?.title ?? 'No item selected!',
          style: textTheme.headline,
        ),
        Text(
          item?.subtitle ?? 'Please select one on the left.',
          style: textTheme.subhead,
        ),
        SizedBox(
          width: double.infinity,
          height: 60.0,
          child: RaisedButton(
            child: Text(
              'Подтвердить заселение',
              style: TextStyle(fontSize: 16.0),
            ),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {},
          ),
        )
      ],
    );

    if (isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(child: content),
      ),
    );
  }
}

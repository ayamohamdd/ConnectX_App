import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connect_x_app/data/db.dart';
import 'package:flutter/material.dart';
Widget attendantItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['image']}',
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['name']}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${DateTime.now()}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
          onPressed: () {
           db().deleteData(
              id: model['id'],
            );
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    ),
  ),
  onDismissed: (direction)
  {
   db().deleteData(id: model['id'],);
  },
);
Widget attendantsBuilder({required List<Map> attendants,}) => ConditionalBuilder(
  condition: attendants.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index)
    {
      return attendantItem(attendants[index], context);
    },
    separatorBuilder: (context, index) =>myseperator(),

    itemCount: attendants.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.person,
          size: 100.0,
          color: Colors.grey,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'No attendants Yet',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);
Widget myseperator ()=> Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
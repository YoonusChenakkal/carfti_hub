import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

customAppBar({required title}) {
  return AppBar(
    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    title: Text(title),
    toolbarHeight: 9.h,
  );
}

homeAppBar(String userName) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    toolbarHeight: 9.h,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $userName',
          style: TextStyle(
            fontSize: 20,
            color: Colors.cyan,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'welcome',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.cyan,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
              ),
            ],
          ),
          child: Icon(Icons.store, color: Colors.white, size: 34),
        ),
      ),
    ],
  );
}

import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/widgets/loading.dart';
import '../helpers/style.dart';
import 'custom_text.dart';
import 'package:butchertesta1916/src/models/category.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(child: Align(
                      alignment: Alignment.center,
                      child: Loading(),
                    ),),
                    Center(
                      child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: category.image),
                    ),
                  ],
                ),
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
//                gradient: LinearGradient(
//                  begin: Alignment.bottomCenter,
//                  end: Alignment.topCenter,
//                  colors: [
//                    Colors.black.withOpacity(1.0),
//                    Colors.black.withOpacity(1.0),
//                    Colors.black.withOpacity(1.0),
//                    Colors.black.withOpacity(1.0),
//                    Colors.black.withOpacity(1.0),
//                    Colors.black.withOpacity(1.0),
//                    Colors.black.withOpacity(1.0),
//                  ],
//                ),
            ),
          ),

          Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomText(text: category.name, color: black, size: 10, weight: FontWeight.normal,)))
        ],
      ),
    );
  }
}
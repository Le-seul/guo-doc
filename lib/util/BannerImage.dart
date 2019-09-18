import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flukit/flukit.dart' as lib1;
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/banner.dart';
import 'package:flutter_first/pages/home/home_page.dart';
import 'package:flutter_first/util/router.dart';

Widget buildBanner(BuildContext context, List<BannerImage> list) {
  if (list == null) {
    return new Container(height: 0.0);
  }
  return new AspectRatio(
    aspectRatio: 16.0 / 9.0,
    child: lib1.Swiper(
      indicatorAlignment: AlignmentDirectional.topEnd,
      circular: true,
      interval: const Duration(seconds: 3),
      indicator: NumberSwiperIndicator(),
      children: list.map((model) {
        return new InkWell(
          onTap: () {
            Router.push(context, model.imgId, {'title': model.name});
          },
          child: new CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: model.imgId,
            placeholder: (context, url) => new ProgressView(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        );
      }).toList(),
    ),
  );
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text("${++index}/$itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}
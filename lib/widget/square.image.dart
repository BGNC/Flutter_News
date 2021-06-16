import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SquareImage extends StatelessWidget {
  final String imageUrl;
  SquareImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    //print(imageUrl);
    return CachedNetworkImage(
      imageUrl: imageUrl,
      // imageBuilder: (context, imageProvider) => Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: imageProvider,
      //         fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
      placeholder: (context, url) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (context, url, error) {
        return Container();
      },
    );
  }
}

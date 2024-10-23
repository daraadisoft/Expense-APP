import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class ImageLoader extends StatelessWidget {

  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? loading;
  final Color? color;

  const ImageLoader({required this.url,this.color,this.fit = BoxFit.cover,this.width,this.height,this.loading});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        color: color,
        fit: fit,
        placeholder: (context,v){
          if(loading !=null) return loading!;
          return SizedBox(
            width: width,
            height: height,
          );
        },
    );
  }
}

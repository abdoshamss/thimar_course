import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? width,height;
  final BoxFit? fit;
  const AppImage  ({Key? key, required this.path, required this.width, required this.height, this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path.startsWith("http")){
      return Image.network(path,width: width,height: height,fit: fit,);
    }else if(path.endsWith(".svg")) {
      return SvgPicture.network(path,width: width,height: height,fit: fit!,);
    }else {
      return Image.asset(path,width: width,height: height,fit: fit,);
    }
  }
}

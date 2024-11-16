import 'package:flutter/material.dart';

class MyNetworkImage extends StatelessWidget {
  final String src;

  const MyNetworkImage(this.src, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, obj, trace) => Container(
        color: Colors.grey,
        child: Center(
          child: Text(
            "حدث خطأ أثناء تحميل الصورة",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

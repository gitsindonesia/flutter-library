import 'package:flutter/material.dart';
import 'package:gits_cached_network_image/src/gits_cached_network_image.dart';

void main(List<String> args) {
  GitsCachedNetworkImage(
    imageUrl: 'https://picsum.photos/id/2/200',
    loadingBuilder: (context) => const CircularProgressIndicator(),
    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
  );
}

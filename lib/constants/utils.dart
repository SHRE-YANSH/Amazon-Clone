import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

double calculateRating(Product product) {
  if (product.ratings.isEmpty) return 4.0;
  double sum = 0;
  for (var i in product.ratings) {
    sum += i['rating'];
  }
  double rating = sum / product.ratings.length;
  return rating;
}

double getRatingByUser(Product product, String userId) {
  double rating = 0;
  if (product.ratings.isEmpty) return 0;
  for (var i in product.ratings) {
    if (i['userId'] == userId) {
      rating += i['rating'];
      break;
    }
  }
  return rating;
}

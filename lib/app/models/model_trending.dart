import 'package:flutter/material.dart';

class ModelTrending {
  String image;
  String title;
  String subTitle;
  String amount;
  String discount;
  Color discountColor;

  ModelTrending(this.image, this.title, this.subTitle, this.amount, {this.discount = "", this.discountColor = Colors.transparent});


}

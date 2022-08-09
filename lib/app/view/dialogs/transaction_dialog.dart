import 'package:flutter/material.dart';
import 'package:screen_sizer/base/color_data.dart';
import 'package:screen_sizer/base/constant.dart';
import 'package:screen_sizer/base/resizer/fetch_pixels.dart';
import 'package:screen_sizer/base/widget_utils.dart';

// ignore: must_be_immutable
class TransactionDialog extends StatefulWidget {
  BuildContext context;
  Function onChanged;
  String title;
  bool withClose;

  @override
  _TransactionDialog createState() {
    return _TransactionDialog();
  }

  TransactionDialog(this.context, this.onChanged, this.title,
      {this.withClose = false, Key? key})
      : super(key: key);
}

class _TransactionDialog extends State<TransactionDialog> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);

    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
          ),
          elevation: 0.0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: dialogContent(context, setState),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  dialogContent(BuildContext context, var setState) {
    Widget getHor = getHorSpace(FetchPixels.getPixelWidth(30));
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: FetchPixels.getDefaultHorSpace(context)),
      padding: EdgeInsets.symmetric(
          horizontal: FetchPixels.getDefaultHorSpace(context)),
      decoration: BoxDecoration(
        color: getCurrentTheme(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          getVerSpace(FetchPixels.getPixelHeight(30)),
          Align(
            alignment: Alignment.topRight,
            child: getCloseButton(context, () {
              Constant.backToPrev(context);
            }),
          ),
          getSvgImageWithSize(context, "transaction.svg",
              FetchPixels.getPixelHeight(96), FetchPixels.getPixelHeight(96)),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getMultilineCustomFont(
              "You successfully purchased space\nshipping from NFTS.",
              15,
              getFontColor(context),
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
              txtHeight: 1.46),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          Divider(
            height: FetchPixels.getPixelHeight(1),
            color: getCurrentTheme(context).focusColor,
          ),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getCustomFont("Transaction ID", 15, getFontColor(context), 1,
                  fontWeight: FontWeight.w400),
              Expanded(
                child: getHorSpace(0),
                flex: 1,
              ),
              getCustomFont(widget.title, 15, getFontColor(context), 1,
                  fontWeight: FontWeight.w600),
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(25)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getCustomFont("Status", 15, getFontColor(context), 1,
                  fontWeight: FontWeight.w400),
              Expanded(
                child: getHorSpace(0),
                flex: 1,
              ),
              getSubButton(context, "#FFFBEC".toColor(), true, "Purchasing",
                  "#F39F21".toColor(), () {}, EdgeInsets.zero,
                  width: FetchPixels.getPixelWidth(112))
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(39)),
          getCustomFont("Social Show Off", 15, getFontColor(context), 1,
              fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getButtonIcon("insta.svg"),
              getHor,
              getButtonIcon("fb.svg"),
              getHor,
              getButtonIcon("twitter.svg"),
              getHor,
              getButtonIcon("pinterest.svg")
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(40)),
        ],
      ),
    );
  }

  getButtonIcon(String image) {
    double size = FetchPixels.getPixelHeight(34);
    return getSvgImageWithSize(context, image, size, size);
  }
}

import 'package:flutter/material.dart';
import 'package:shopv1deliveryfood_mobile/constants/texts/text_styles.dart';

class ModalTextButton extends StatelessWidget {
  final title;
  final callback;
  final source;
  final Function()? notifyParent;

  const ModalTextButton(this.title, {Key? key, this.callback, this.source, this.notifyParent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyles.black_16_w700.copyWith(fontWeight: FontWeight.w400),
                )
            ),
          )
      ),
      onTap: () {
        Navigator.of(context).pop();
        if(callback != null)
          callback(source);
        else
          notifyParent!();
      },
    );
  }
}

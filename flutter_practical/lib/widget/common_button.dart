
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonButton extends StatefulWidget {
  final String? text;
  final VoidCallback? onConfirm;
  FocusNode? focusNode;
  bool isOutlinedBorderButton = false;

  CommonButton({this.text,this.onConfirm,this.focusNode,this.isOutlinedBorderButton = false,Key? key}) : super(key: key);

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    return ElevatedButton(
      focusNode: widget.focusNode,
      child: Text(
        widget.text!,
        textAlign: TextAlign.left,
        style: widget.isOutlinedBorderButton ? GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 0.045 * queryData.size.width, fontWeight: FontWeight.w500, color: Colors.blue
          ),
        ) : GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 0.045 * queryData.size.width, fontWeight: FontWeight.w500
          ),
        ),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0.0),
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white,),
          backgroundColor: widget.isOutlinedBorderButton ? MaterialStateProperty.all<Color>(Colors.transparent) : MaterialStateProperty.all<Color>(
            Colors.blue),

          shape: MaterialStateProperty.all<
              RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(
                color: Colors.blue),
            ),
          ),
          alignment: Alignment.center
      ),
      onPressed: widget.onConfirm,
    );
  }
}

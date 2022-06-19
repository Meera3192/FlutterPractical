
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonInputTextBox extends StatefulWidget {
  final String? text;
  final String? hintText;

  final double? boxHeight;
  final double? boxWidth;
  final int? textLimit;
  bool showForgotPasswordOption = false;


  bool? validateField = false;
  bool? isEnabled = false;

  TextEditingController tf_controller;
  late FocusNode focusNode;
  late FocusNode nextFocusNode;
  VoidCallback? onPasswordSubmitted;

  CommonInputTextBox({this.text, this.hintText, this.boxHeight, this.boxWidth, this.textLimit,
      required this.tf_controller, required this.focusNode, required this.nextFocusNode, required this.isEnabled,});

  @override
  _CommonInputTextBoxState createState() => _CommonInputTextBoxState();
}

class _CommonInputTextBoxState extends State<CommonInputTextBox> {
  late FocusNode focusNode;
  late FocusNode nextFocusNode;
  bool _obscureText = true;


  @override
  void initState() {
    focusNode = FocusNode();
    nextFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    nextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RichText(text:
                TextSpan(children:[
                  TextSpan(
                    text:widget.text!,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Color(0xaa212529),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  /*TextSpan(
                    text: Strings.requiredSign,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Color(0xaae30909),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),*/
                ],
                ),
                ),
              ],
            ),
            (widget.validateField!)? Text(
              "required",
              textAlign: TextAlign.left,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ) : Text(''),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: widget.boxHeight,
          width: widget.boxWidth,
          child: TextFormField(
            controller: widget.tf_controller,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            //keyboardType: TextInputType.text,
            onFieldSubmitted: (term) {

            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
            inputFormatters: [

              FilteringTextInputFormatter.singleLineFormatter,
              LengthLimitingTextInputFormatter(widget.textLimit),
            ],
            enabled: widget.isEnabled,
            obscureText:  false,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: GoogleFonts.inter(
                color: Color(0xaa8b8b8b)
              ),
              contentPadding: EdgeInsets.only(left: 10),
              //contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(7)),
                borderSide: BorderSide(width: 1, color: Color(0xffe9e9e9)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(7)),
                borderSide: BorderSide(width: 1, color: Color(0xffe9e9e9)),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide(
                      width: 1, color: Colors.blue)),
              errorBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(7)),
                  borderSide:
                  const BorderSide(width: 1, color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(7)),
                  borderSide:
                  const BorderSide(width: 1, color: Colors.red)),
              fillColor: Colors.white,
              filled: true,
              errorStyle: TextStyle(height: 0),
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xffe9e9e9)),
              ),
            ),
            style: GoogleFonts.inter(
              fontSize: 15,
            ),
            cursorColor: Colors.blue,
          ),
        ),
      ],
    );
  }

}
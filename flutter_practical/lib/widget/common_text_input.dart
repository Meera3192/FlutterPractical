
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {


  final Function(String) onChanged;

  final String labelText;
  final String value;

  const TextInput({Key? key,required this.onChanged, this.labelText = "",this.value=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        initialValue: value,
        style: TextStyle(
            color: Colors.white
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: labelText,
          hintStyle: TextStyle(
              color: Colors.white
          ),
          labelStyle: TextStyle(
            color: Colors.white
          )
        ),
      ),
    );
  }
}

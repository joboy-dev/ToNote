import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoey/shared/constants.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.onChanged,
  });

  final String? initialValue;
  final String hintText;
  final Function(String? value) onChanged;
  // Function(String? newValue) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: kTextFieldStyle.copyWith(color: kGreyTextColor),
      cursorColor: kYellowColor,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
        hintStyle: kTextFieldStyle.copyWith(color: kGreyTextColor),
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            Icons.person,
            color: kYellowColor,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          // disableButton = true;
          return 'This field cannot be empty';
        } else {
          return null;
        }
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key, 
    this.initialValue,
    this.readOnly,
    required this.onChanged,
    this.color,
    // required this.disableButton,
  });

  final String? initialValue;
  final bool? readOnly;
  final Color? color;
  // bool disableButton;

  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      initialValue: initialValue,
      cursorColor: kYellowColor,
      keyboardType: TextInputType.emailAddress,
      style: kTextFieldStyle.copyWith(color: kGreyTextColor),
      decoration: kTextFieldDecoration.copyWith(
        hintText: 'Email',
        hintStyle: kTextFieldStyle.copyWith(color: kGreyTextColor),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            Icons.email_rounded,
            color: color ?? kYellowColor,
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        return RegExp(
                    r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!)
            ? null
            : 'Please enter a valid email';
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key, 
    required this.hintText,
    required this.obscureText,
    required this.onChanged,
    required this.onTap,
    this.color
  });

  final String hintText;
  final bool obscureText;
  final Color? color;
  final Function(String? value) onChanged;
  final Function() onTap; // for gesture detector

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kYellowColor,
      style: kTextFieldStyle.copyWith(color: kGreyTextColor),
      obscureText: obscureText,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
        hintStyle: kGreyNormalTextStyle.copyWith(fontSize: 14.0),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Icon(
            Icons.lock,
            color: color ?? kYellowColor,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            onTap: onTap,
            child: obscureText
                ? Icon(
                    FontAwesomeIcons.solidEye,
                    color: color ?? kYellowColor,
                    size: 20.0,
                  )
                : Icon(
                    FontAwesomeIcons.solidEyeSlash,
                    color: color ?? kYellowColor,
                    size: 20.0,
                  ),
          ),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        return RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                .hasMatch(value!)
            ? null
            : 'Your password should have an uppercase letter, lowercase letter, a symbol and number';
      },
    );
  }
}

class NormalTextField extends StatelessWidget {
  const NormalTextField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.focusedErrorBorderColor,
    required this.errorTextStyleColor,
    required this.iconColor,
    required this.cursorColor,
    required this.prefixIcon,
    this.suffixIcon,
    this.readonly,
    this.fontSize,
    this.textInputType,
  });

  final String? initialValue;
  final String hintText;
  final bool? readonly;
  final Function(String? value) onChanged;
  final Color enabledBorderColor;
  final bool obscureText;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color iconColor;
  final Color cursorColor;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final double? fontSize;
  final TextInputType? textInputType;
  // Function(String? newValue) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly ?? false,
      initialValue: initialValue,
      style: kTextFieldStyle.copyWith(fontSize: fontSize ?? 14.0),
      cursorColor: cursorColor,
      obscureText: obscureText,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: kTextFieldStyle.copyWith(
            color: kTextColor, fontSize: fontSize ?? 14.0),
        prefixIcon: Icon(
          prefixIcon,
          color: iconColor,
        ),
        suffixIcon: Icon(suffixIcon),
        labelStyle: const TextStyle(
          color: kYellowColor,
          fontWeight: FontWeight.w300,
          fontSize: 10.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedErrorBorderColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        errorStyle: TextStyle(
          color: errorTextStyleColor,
        ),
      ),
      // onSaved: onSaved,
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          // disableButton = true;
          return 'This field cannot be empty';
        } else {
          return null;
        }
      },
    );
  }
}

class TextareaTextField extends StatelessWidget {
  const TextareaTextField({
    super.key,
    this.initialValue,
    this.readonly,
    required this.hintText,
    required this.onChanged,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    required this.errorTextStyleColor,
    required this.cursorColor,
  });

  final String? initialValue;
  final String hintText;
  final bool? readonly;
  final Function(String? value) onChanged;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color cursorColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly ?? false,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      initialValue: initialValue,
      style: kTextFieldStyle,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: kTextFieldStyle.copyWith(color: kTextColor.withOpacity(0.5)),
        labelStyle: const TextStyle(
          color: kYellowColor,
          fontWeight: FontWeight.w300,
          fontSize: 10.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: enabledBorderColor ?? Colors.transparent, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: focusedBorderColor ?? Colors.transparent, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: errorBorderColor ?? Colors.transparent, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: focusedErrorBorderColor ?? Colors.transparent, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        errorStyle: TextStyle(
          color: errorTextStyleColor,
        ),
      ),
      // onSaved: onSaved,
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty || value.length < 15) {
          return 'This field must not be less than 15 characters';
        } else {
          return null;
        }
      },
    );
  }
}

class DateTimeField extends StatelessWidget {
  const DateTimeField({
    super.key,
    required this.hintText,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.focusedErrorBorderColor,
    required this.errorTextStyleColor,
    required this.iconColor,
    required this.onSaved,
    this.initialValue,
  });

  final String hintText;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color focusedErrorBorderColor;
  final Color errorTextStyleColor;
  final Color iconColor;
  final String? initialValue;
  final Function(DateTime? date)? onSaved;

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    return FormField<DateTime>(
      // initialValue: DateTime.parse(initialValue!) ?? DateTime.parse( now.toIso8601String().substring(0, 10)),
      builder: (dateState) {
        return InputDecorator(
          decoration: InputDecoration(
            hintText: '',
            hintStyle:
                kTextFieldStyle.copyWith(color: Colors.black.withOpacity(0.5)),
            prefixIcon: Icon(
              FontAwesomeIcons.calendar,
              color: iconColor,
            ),
            labelStyle: const TextStyle(
              color: kYellowColor,
              fontWeight: FontWeight.w300,
              fontSize: 10.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: enabledBorderColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorBorderColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: focusedErrorBorderColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            errorStyle: TextStyle(
              color: errorTextStyleColor,
            ),
          ),
          child: InkWell(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: dateState.value ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null && pickedDate != dateState.value) {
                dateState.didChange(pickedDate);
                // selectedDate = pickedDate;
              }
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    dateState.value != null
                        ? dateState.value!.toIso8601String().substring(0, 10)
                        : 'Pick expiry date',
                    style: kTextFieldStyle.copyWith(color: kGreyTextColor),
                  ),
                ),
                const Expanded(
                  flex: 0,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: kGreenColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a date';
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}

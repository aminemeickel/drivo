import 'package:drivo/Utils/notification.dart';
import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/main_button.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:drivo/controllers/auth_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  static const id = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isChecked = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SizedBox.fromSize(
        size: Get.size,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageFromassets('logo_red.png'),
              Container(
                margin: EdgeInsets.only(top: Get.height * .14),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                width: Get.width * .9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 20)
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text('LOG IN',
                          style:
                              TextStyle(color: kAppPrimaryColor, fontSize: 20)),
                      const SizedBox(height: 30),
                      LoginFormFiled(
                        hint: 'Username',
                        prefixIcon: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: imageFromassets('person.png',
                                width: 10, height: 10)),
                        textEditingController: _mailController,
                        validator: (val) =>
                            val!.isEmail ? null : 'Wrong format',
                      ),
                      const SizedBox(height: 20),
                      LoginFormFiled(
                        hint: 'Passwrod',
                        prefixIcon:
                            const Icon(Icons.lock, color: kAppPrimaryColor),
                        textEditingController: _passwordController,
                        isPassword: true,
                        validator: (val) => val!.length > 4 ? null : 'To short',
                      ),
                      ListTileTheme(
                        horizontalTitleGap: 0,
                        child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            value: _isChecked,
                            activeColor: kAppPrimaryColor,
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Color(0XFFD7D7D7))),
                            onChanged: (val) => setState(() {
                                  _isChecked = val!;
                                }),
                            title: const Text.rich(TextSpan(
                                text: 'I agree to the ',
                                children: [
                                  TextSpan(
                                      text: 'terms of service',
                                      style: TextStyle(color: kAppPrimaryColor))
                                ]))),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                          width: Get.width,
                          height: 45,
                          child: MainButton(
                              onpressd: _signIn,
                              text: const Text('Continue',
                                  style: TextStyle(fontSize: 18)))),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    if (_isChecked) {
      if (_formKey.currentState!.validate()) {
        var response = await ApiService.login(
            username: _mailController.text, password: _passwordController.text);
        if (response != null && response.statusCode == 200) {
          await NotificationHandler().initFirebaseMessaging();
          AuthController.initControllers();
          Get.offAllNamed(HomePage.id);
        } else {
          var messages = response?.data;
          if (messages != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(messages['message'])));
          }
        }
      }
    } else {
      Fluttertoast.showToast(msg: 'Please read and agree on terms');
    }
  }
}

class LoginFormFiled extends StatelessWidget {
  final String hint;
  final Widget prefixIcon;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final TextEditingController textEditingController;
  const LoginFormFiled(
      {Key? key,
      required this.hint,
      required this.prefixIcon,
      required this.textEditingController,
      this.isPassword = false,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        controller: textEditingController,
        textAlignVertical: TextAlignVertical.bottom,
        style: const TextStyle(fontSize: 16),
        validator: validator,
        obscureText: isPassword,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: _border,
            hintText: hint,
            enabledBorder: _border,
            focusedBorder: _border),
      ),
    );
  }

  InputBorder get _border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0XFFD7D7D7)));
}

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:n_e_commmerce/service/login_service.dart';
import 'package:n_e_commmerce/view/register.dart';
import 'package:n_e_commmerce/widgets/custom_button.dart';
import 'package:n_e_commmerce/widgets/custom_snackbar.dart';
import 'package:n_e_commmerce/widgets/custom_text_field.dart';
import 'package:n_e_commmerce/widgets/loading_popup.dart';

import 'base_scaffold.dart';

class Login extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.15, bottom: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Giriş Yap",
                  style: Theme.of(context).textTheme.headline3,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 15),
                  child: Text(
                    "E-Mail",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CustomTextField(
                  hintText: "E-Mail adresinizi giriniz..",
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 15),
                  child: Text(
                    "Şifre",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CustomTextField(
                  isPassword: true,
                  passwordField: true,
                  hintText: "Şifrenizi giriniz..",
                  controller: password,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Şifremi Unuttum"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: CustomButton(
                        text: "Giriş Yap",
                        onTap: () {
                          loadingPopup(context);
                          LoginService.fetch(
                                  email: email.text, password: password.text)
                              .then((value) {
                            Navigator.pop(context);
                            if (value != null) {
                              if (value.status!) {
                                GetStorage().write("token", value.token);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BaseScaffold()),
                                    (route) => false);
                              } else {
                                customSnackbar(context,
                                    value.message ?? "Bir sorun oluştu.");
                              }
                            } else {
                              customSnackbar(context, "Bir sorun oluştu.");
                            }
                          });
                        })),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: CustomButton(
                  text: "Kayıt Ol",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

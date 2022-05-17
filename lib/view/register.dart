import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:n_e_commmerce/service/register_service.dart';
import 'package:n_e_commmerce/view/base_scaffold.dart';
import 'package:n_e_commmerce/view/login.dart';
import 'package:n_e_commmerce/widgets/custom_button.dart';
import 'package:n_e_commmerce/widgets/custom_text_field.dart';

import '../widgets/custom_snackbar.dart';
import '../widgets/loading_popup.dart';

class Register extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
                  "Kayıt Ol",
                  style: Theme.of(context).textTheme.headline3,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 15),
                  child: Text(
                    "isim",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CustomTextField(
                  hintText: "İsminizi giriniz..",
                  controller: name,
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
                    "Telefon",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                CustomTextField(
                  hintText: "Telefon numaranızı giriniz..",
                  keyboardType: TextInputType.phone,
                  controller: phone,
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
                    text: "Kayıt Ol",
                    onTap: () {
                      loadingPopup(context);
                      RegisterService.fetch(
                              email: email.text,
                              password: password.text,
                              name: name.text,
                              phone: phone.text)
                          .then((value) {
                        Navigator.pop(context);
                        if (value != null) {
                          if (value.status!) {
                            GetStorage().write("token", value.token);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BaseScaffold()),
                                (route) => false);
                          } else {
                            customSnackbar(
                                context, value.message ?? "Bir sorun oluştu.");
                          }
                        } else {
                          customSnackbar(context, "Bir sorun oluştu.");
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: CustomButton(
                  text: "Giriş Yap",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
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

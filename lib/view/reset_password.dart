import 'package:flutter/material.dart';
import 'package:n_e_commmerce/service/reset_password_service.dart';
import 'package:n_e_commmerce/widgets/custom_appbar.dart';
import 'package:n_e_commmerce/widgets/custom_button.dart';

import '../widgets/custom_snackbar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_popup.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController last = TextEditingController();
  TextEditingController newP = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        text: "Güvenlik Ayarları",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 15),
              child: Text(
                "Eski Şifre",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            CustomTextField(
              hintText: "Eski şifrenizi giriniz..",
              controller: last,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 15),
              child: Text(
                "Yeni Şifre",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            CustomTextField(
              hintText: "Yeni şifrenizi giriniz..",
              controller: newP,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 15),
              child: Text(
                "Yeni Şifre Tekrar",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            CustomTextField(
              hintText: "Yeni şifrenizi tekrar giriniz..",
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
              text: "Şifreyi Güncelle",
              onTap: () {
                loadingPopup(context);
                ResetPasswordService.fetch(last: last.text, newP: newP.text)
                    .then((value) {
                  Navigator.pop(context);
                  if (value != null && value.status == true) {
                    customSnackbar(context, value.message!);
                    Navigator.pop(context);
                  } else {
                    customSnackbar(context, "Bir sorun oluştu");
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

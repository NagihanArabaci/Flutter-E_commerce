import 'package:flutter/material.dart';
import 'package:n_e_commmerce/service/user_update_service.dart';
import 'package:n_e_commmerce/widgets/custom_appbar.dart';
import 'package:n_e_commmerce/widgets/custom_button.dart';
import 'package:n_e_commmerce/widgets/custom_snackbar.dart';
import 'package:n_e_commmerce/widgets/custom_text_field.dart';
import 'package:n_e_commmerce/widgets/loading_popup.dart';

class UserDetail extends StatefulWidget {
  String userName;
  String userEmail;
  String userPhone;
  UserDetail({
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });
  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      email = TextEditingController(text: widget.userEmail);
      name = TextEditingController(text: widget.userName);
      phone = TextEditingController(text: widget.userPhone);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        text: "Kullanıcı Bilgileri",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 15),
              child: Text(
                "İsim",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            CustomTextField(
              hintText: "İsim",
              controller: name,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 15),
              child: Text(
                "Telefon",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            CustomTextField(
              hintText: "Telefon",
              keyboardType: TextInputType.phone,
              controller: phone,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 15),
              child: Text(
                "E-Mail",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            CustomTextField(
              hintText: "E-Mail",
              keyboardType: TextInputType.emailAddress,
              controller: email,
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
              text: "Bilgileri Güncelle",
              onTap: () {
                loadingPopup(context);
                UserUpdateService.fetch(
                        email: email.text, name: name.text, phone: phone.text)
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

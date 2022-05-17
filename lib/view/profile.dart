import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/user_model.dart';
import 'package:n_e_commmerce/service/image_upload_service.dart';
import 'package:n_e_commmerce/service/user_service.dart';
import 'package:n_e_commmerce/view/home.dart';
import 'package:n_e_commmerce/view/reset_password.dart';
import 'package:n_e_commmerce/view/splash.dart';
import 'package:n_e_commmerce/view/user_detail.dart';
import 'package:n_e_commmerce/widgets/custom_snackbar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();

  File? imageFile;

  Future galleryImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        ImageUploadService.fetch(file: File(image.path)).then((value) {
          if (value) {
            customSnackbar(context, "Resminiz başarıyla güncellendi.");
          } else {
            customSnackbar(context, "Resminiz güncellenirken bir sorun oluştu");
          }
        });
      });
    }
  }

  Future cameraImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        ImageUploadService.fetch(file: File(image.path)).then((value) {
          if (value) {
            customSnackbar(context, "Resminiz başarıyla güncellendi.");
          } else {
            customSnackbar(context, "Resminiz güncellenirken bir sorun oluştu");
          }
        });
      });
    }
  }

  UserModelData? model;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    UserService.fetch().then((value) {
      if (value != null && value.status == true) {
        model = value.data!;
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading == false
          ? const LoadingWidget()
          : SingleChildScrollView(
              padding: EdgeInsets.only(
                  top: size.height * 0.06, left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: size.width * 0.4,
                          height: size.width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 10)
                            ],
                            image: DecorationImage(
                                image: imageFile == null
                                    ? NetworkImage(
                                        "${Constant.imageBaseUrl}uploads/avatar/${model!.avatar!}")
                                    : FileImage(imageFile!) as ImageProvider),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              imageLoadPhone(context);
                            },
                            child: const Icon(
                              CupertinoIcons.photo_camera_solid,
                              size: 36,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 40),
                    child: Text(
                      model?.name ?? "",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  cardItem(
                      icon: Icons.edit_note_rounded,
                      text: "Kullanıcı Bilgileri",
                      onTap: UserDetail(
                        userEmail: model!.email!,
                        userName: model!.name!,
                        userPhone: model!.phone!.toString(),
                      )),
                  cardItem(
                      icon: CupertinoIcons.settings,
                      text: "Güvenlik Ayarları",
                      onTap: const ResetPassword()),
                  TextButton(
                    onPressed: () {
                      GetStorage().remove("token");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Splash(),
                        ),
                      );
                    },
                    child: Text(
                      "Çıkış Yap",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget cardItem({
    required IconData icon,
    required String text,
    required Widget onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => onTap));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.grey.shade400,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> imageLoadPhone(BuildContext context) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: const Text('Seçiminizi yapın'),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text('Kamera'),
                onPressed: () {
                  Navigator.pop(context);
                  cameraImage();
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Galeri'),
                onPressed: () {
                  Navigator.pop(context);
                  galleryImage();
                },
              ),
            ],
          );
        });
  }
}

import 'dart:convert';

import 'package:contadores_invia/Util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  final _formKey = GlobalKey<FormState>();
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _enviaInfoViaEmail() async {
    String apiKey =
        "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";
    Uri url = Uri.parse("https://api.sendinblue.com/v3/smtp/email");
    Map<String, String> headers = {
      "accept": "application/json",
      "api-key": apiKey,
      "content-type": "application/json"
    };
    Map<String, dynamic> body = {
      "sender": {
        "name": "Assinante WEBPKI ODONTO - Starter",
        "email": "webpki@webpki.com.br"
      },
      "to": [
        {"email": "marcioperondi@invia.com.br", "name": "Márcio Elias Perondi"},
        {"email": "financeiro@invia.com.br", "name": "Sulamita Moraes"},
        {"email": "vendas9@invia.com.br", "name": "Leonardo"},
        {"email": "desenvolvimento1@invia.com.br", "name": "Marcos Freitas"}
      ],
      "subject": "Assinatura WEBPKI ODONTO - Starter",
      "htmlContent": ""
    };

    http.Response response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    debugPrint(response.body);
  }

  Widget _customTextField(String hintText, String labelText) {
    return TextFormField(
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Este campo não pode ser vazio!';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        fillColor: const Color(0xFFEFEFEF),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contato'),
        backgroundColor: HexColor(darkBlue),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor(darkBlue),
          systemNavigationBarColor: HexColor(darkBlue),
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Envie-nos uma mensagem com qualquer coisa que você queira saber ou perguntar sobre os nossos serviços, e entraremos em contato com você imediatamente.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0.sp,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(
                        'https://api.whatsapp.com/send/?phone=555133370880&text&type=phone_number&app_absent=0');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.green,
                          child: FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'WhatsApp',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          '+55 51 3337.0880',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl('tel:5133370880');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.green,
                          child: FaIcon(
                            FontAwesomeIcons.phone,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'Telefone',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          '+55 51 3337.0880',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl('mailto:contato@aprove.com.br');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.green,
                          child: FaIcon(
                            FontAwesomeIcons.envelope,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'E-mail',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'contato@aprove.com.br',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(
                        'https://www.google.com/maps/place/Aprove+Contabilidade+Sociedade+Simples/@-30.0247277,-51.1849469,17z/data=!3m1!4b1!4m5!3m4!1s0x95197994dd41b2bf:0x69ad3d2c35c48f7d!8m2!3d-30.0247324!4d-51.1827582');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.green,
                          child: FaIcon(
                            FontAwesomeIcons.locationDot,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'Endereço',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'Av. Carlos Gomes, 328 - 6º andar | Mercosul Center | Bairro Bela Vista | Porto Alegre / RS CEP 90480-000',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.0.h),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      _customTextField('Insira o seu nome', 'Nome'),
                      SizedBox(
                        height: 24.0.h,
                      ),
                      _customTextField('Insira o seu sobrenome', 'Sobrenome'),
                      SizedBox(
                        height: 24.0.h,
                      ),
                      _customTextField('Insira o seu telefone', 'Telefone'),
                      SizedBox(
                        height: 24.0.h,
                      ),
                      _customTextField('Insira o seu e-mail', 'E-mail'),
                      SizedBox(
                        height: 24.0.h,
                      ),
                      TextFormField(
                        minLines: 5,
                        maxLines: 5,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Este campo não pode ser vazio!';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Insira a sua mensagem',
                          labelText: 'Mensagem',
                          fillColor: const Color(0xFFEFEFEF),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.0.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor(darkBlue),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text('Enviar mensagem'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:contadores_invia/Util/colors.dart';
import 'package:contadores_invia/Views/notification.dart';
import 'package:contadores_invia/Views/social_media.dart';
import 'package:contadores_invia/Views/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _advancedDrawerController = AdvancedDrawerController();
  BannerAd? bannerAd;
  bool isLoaded = false;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId =
      Platform.isAndroid ? 'ca-app-pub-4172869125001657~2445179444' : '';

  void loadAd() {
    setState(() {
      bannerAd = BannerAd(
        adUnitId: adUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            setState(() {
              isLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            debugPrint('BannerAd failed to load: $err');
            ad.dispose();
          },
        ),
      )..load();
    });
  }

  Widget listItemDrawer(Icon leading, String title, Widget screen) {
    return ListTile(
      onTap: () {
        Get.to(() => screen);
      },
      leading: leading,
      title: Text(title),
      dense: true,
      enableFeedback: true,
      iconColor: HexColor(darkBlue),
      textColor: HexColor(darkBlue),
      tileColor: Colors.white,
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      drawer: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0.h),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1,
              color: HexColor(darkBlue),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 24.0.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [HexColor(darkBlue), HexColor(blue)]),
                  border: Border(
                    right: BorderSide(
                      width: 1,
                      color: HexColor(darkBlue),
                    ),
                  ),
                ),
                child: Image.network(
                  'https://aprove.com.br/wp-content/uploads/2023/06/LOGO-36-ANOS.png',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      color: HexColor(darkBlue),
                    ),
                    listItemDrawer(
                      const Icon(Icons.info),
                      'Quem Somos',
                      const WebView(
                          title: ('Quem Somos'),
                          url: 'https://aprove.com.br/quem-somos/'),
                    ),
                    Container(
                      height: 1,
                      color: HexColor(darkBlue),
                    ),
                    listItemDrawer(
                      const Icon(Icons.design_services),
                      'Serviços',
                      const WebView(
                          title: ('Serviços'),
                          url: 'https://aprove.com.br/servicos/'),
                    ),
                    Container(
                      height: 1,
                      color: HexColor(darkBlue),
                    ),
                    listItemDrawer(
                      const Icon(Icons.construction),
                      'Estrutura',
                      const WebView(
                          title: ('Estrutura'),
                          url: 'https://aprove.com.br/estrutura/'),
                    ),
                    Container(
                      height: 1,
                      color: HexColor(darkBlue),
                    ),
                    listItemDrawer(
                      const Icon(Icons.label_important),
                      'Legislação',
                      const WebView(
                          title: ('Legislação'),
                          url: 'https://aprove.com.br/legislacao/'),
                    ),
                    Container(
                      height: 1,
                      color: HexColor(darkBlue),
                    ),
                    listItemDrawer(
                      const Icon(Icons.document_scanner),
                      'Para ser MEI',
                      const WebView(
                          title: ('Para ser MEI'),
                          url: 'https://aprove.com.br/para-ser-mei/'),
                    ),
                    Container(
                      height: 1,
                      color: HexColor(darkBlue),
                    ),
                    listItemDrawer(
                      const Icon(Icons.contacts),
                      'Contato',
                      const SocialMedia(),
                    ),
                    Container(
                      height: 1,
                      color: HexColor(darkBlue),
                    ),
                    listItemDrawer(
                      const Icon(Icons.privacy_tip),
                      'Política de privacidade',
                      const WebView(
                          title: ('Polítiva de Privacidade'),
                          url:
                              'https://aprove.com.br/politica-de-privacidade/'),
                    ),
                    Container(
                      height: 1,
                      color: HexColor(darkBlue),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: HexColor(darkBlue),
                        ),
                        onPressed: () {
                          _launchUrl(
                              'https://www.centraldecontabilidade.com.br/econtabil/login.asp?txtDominio=aprove');
                        },
                        child: const Text('Aprove Virtual'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: HexColor(darkBlue)),
                        onPressed: () {
                          _launchUrl(
                              'https://aprove.app.questorpublico.com.br/entrar');
                        },
                        child: const Text('e-DOC'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: HexColor(darkBlue)),
                        onPressed: () {
                          _launchUrl(
                              'http://rubi.aprove.com.br/rubiweb/quiosque.html');
                        },
                        child: const Text('CONTRACHEQUE'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      controller: _advancedDrawerController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor(darkBlue),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor(darkBlue),
            systemNavigationBarColor: HexColor(darkBlue),
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          leading: IconButton(
            onPressed: () {
              _advancedDrawerController.showDrawer();
            },
            icon: const Icon(Icons.menu_open),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.notifications),
            ),
          ],
          title: const Text('Home'),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.0.h),
                child: Text(
                  'APROVE Contabilidade',
                  style: TextStyle(fontSize: 32.0.sp, color: Colors.black),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.0.h),
                child: Text(
                  'CONTABILIDADE é o que a gente gosta e sabe fazer há 36 anos',
                  style: TextStyle(fontSize: 16.0.sp, color: Colors.grey),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.0.h),
                child: ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.whatsapp),
                  onPressed: () {
                    _launchUrl(
                        'https://api.whatsapp.com/send/?phone=555133370880&text&type=phone_number&app_absent=0');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text('Fale com a gente'),
                ),
              ),
              SizedBox(
                height: 350.h,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 36.w,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const WebView(
                                    title: 'Quem Somos',
                                    url: 'https://aprove.com.br/quem-somos/'),
                              );
                            },
                            child: Container(
                              width: 250.w,
                              height: 250.h,
                              decoration: BoxDecoration(
                                color: HexColor(blue),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 32.5.h),
                                    Text(
                                      'Quem Somos',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.sp),
                                    ),
                                    SizedBox(height: 24.h),
                                    Text(
                                      'A APROVE tem o DNA da família Biehl e é administrada até hoje por seus fundadores.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          shadows: [
                                            Shadow(
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.25),
                                              blurRadius: 2.0.r,
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -32.5,
                            right: 35,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/images/estrutura-300x300.png',
                                height: 65,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 36.w,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const WebView(
                                    title: 'Serviços',
                                    url: 'https://aprove.com.br/servicos/'),
                              );
                            },
                            child: Container(
                              width: 250.w,
                              height: 250.h,
                              decoration: BoxDecoration(
                                color: HexColor(blue),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 32.5.h),
                                    Text(
                                      'Serviços',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.sp),
                                    ),
                                    SizedBox(height: 24.h),
                                    Text(
                                      'Desde a sua fundação, a Aprove busca prestar atendimento completo às pequenas, médias e grandes empresas, com uma gama ampla de serviços em todas as áreas que envolvem os processos do setor de contabilidade.',
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          shadows: [
                                            Shadow(
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.25),
                                              blurRadius: 2.0.r,
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -32.5,
                            right: 35,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/images/servicos-300x300.png',
                                height: 65,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 36.w,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const WebView(
                                    title: 'Estrutura',
                                    url: 'https://aprove.com.br/estrutura/'),
                              );
                            },
                            child: Container(
                              width: 250.w,
                              height: 250.h,
                              decoration: BoxDecoration(
                                color: HexColor(blue),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 32.5.h),
                                    Text(
                                      'Estrutura',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.sp),
                                    ),
                                    SizedBox(height: 24.h),
                                    Text(
                                      'Contando hoje com mais de 30 colaboradores, a Aprove tem em sua equipe profissionais com formação superior ou formação técnica em Contabilidade, além de profissionais graduados em áreas afins, como Economia.',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          shadows: [
                                            Shadow(
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.25),
                                              blurRadius: 2.0.r,
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -32.5,
                            right: 35,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/images/estrutura-300x300.png',
                                height: 65,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 36.w,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const WebView(
                                    title: 'Legislação',
                                    url: 'https://aprove.com.br/legislacao/'),
                              );
                            },
                            child: Container(
                              width: 250.w,
                              height: 250.h,
                              decoration: BoxDecoration(
                                color: HexColor(blue),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 32.5.h),
                                    Text(
                                      'Legislação',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.sp),
                                    ),
                                    SizedBox(height: 24.h),
                                    Text(
                                      'Para que você fique atualizado, reunimos leis, artigos, portarias e outras publicações legais que impactam o seu negócio.',
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          shadows: [
                                            Shadow(
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.25),
                                              blurRadius: 2.0.r,
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -32.5,
                            right: 35,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/images/legislacao-300x300.png',
                                height: 65,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 36.w,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const WebView(
                                    title: 'Para ser MEI',
                                    url: 'https://aprove.com.br/para-ser-mei/'),
                              );
                            },
                            child: Container(
                              width: 250.w,
                              height: 250.h,
                              decoration: BoxDecoration(
                                color: HexColor(blue),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 32.5.h),
                                    Text(
                                      'Para ser MEI',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.sp),
                                    ),
                                    SizedBox(height: 24.h),
                                    Text(
                                      'Requisitos necessários para ser MEI',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          shadows: [
                                            Shadow(
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.25),
                                              blurRadius: 2.0.r,
                                            ),
                                          ],
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -32.5,
                            right: 35,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: Image.asset(
                                'assets/images/para-ser-mei-300x300.png',
                                height: 65,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 36.w,
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  color: HexColor(darkBlue),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48.r),
                    topRight: Radius.circular(48.r),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 48.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'desde 1987, a APROVE trata com excelência os assuntos contábeis de seus clientes',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0.sp),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                  blurRadius: 10.r),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0.w, vertical: 24.0.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 200.h),
                                const Text(
                                  'Com 36 anos de atuação no Rio Grande do Sul, a Aprove acompanhou as mudanças do mercado e segue oferecendo os melhores serviços de contabilidade, com soluções para pequenas, médias e grandes empresas. Aliando tecnologia e atendimento especializado.',
                                  maxLines: 7,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24.r),
                            topLeft: Radius.circular(24.r),
                          ),
                          child: Image.network(
                            'https://aprove.com.br/wp-content/uploads/2021/09/foto_de_galeria_237-web.jpg',
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36.h),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                  blurRadius: 10.r),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0.w, vertical: 24.0.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 200.h),
                                const Text(
                                  'Quando foi criada, em 1987, a Aprove Contabilidade tinha em sua equipe apenas os seus três fundadores. De lá para cá, a empresa, que funcionava em 28 m2, enfrentou desafios e conquistou vitórias.',
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24.r),
                            topLeft: Radius.circular(24.r),
                          ),
                          child: Image.network(
                            'https://aprove.com.br/wp-content/uploads/2022/03/md2017_03_12-101402-boa-1024x683.jpg',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36.h),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                  blurRadius: 10.r),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0.w, vertical: 24.0.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 200.h),
                                const Text(
                                  'Hoje, são dezenas de colaboradores e, depois de algumas mudanças, de endereço devido ao contínuo processo de expansão, uma infraestrutura de 360 m² no Edifício Mercosul da Av. Carlos Gomes, 328, foi completamente remodelada para atender seus clientes.',
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24.r),
                            topLeft: Radius.circular(24.r),
                          ),
                          child: Image.network(
                            'https://aprove.com.br/wp-content/uploads/2022/04/pessoal-05-1024x683.jpg',
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36.h),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 400.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                                  blurRadius: 10.r),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(24.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0.w, vertical: 24.0.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 200.h),
                                const Text(
                                  'A nova sede veio junto com a modernização da plataforma de trabalho em 2016, que contava com a Tecnologia da Informação para o tratamento de dados e otimização dos processos contábeis: “O local foi totalmente adequado para que nossas necessidades fossem totalmente atendidas, tornando ainda mais aprazível o espaço para os colaboradores e para o atendimento dos clientes”, Nestor J. Biehl.',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24.r),
                            topLeft: Radius.circular(24.r),
                          ),
                          child: Image.network(
                            'https://aprove.com.br/wp-content/uploads/2022/04/pessoal-06-1024x684.jpg',
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

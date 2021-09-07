import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homepick_print/data/models/product.dart';
import 'package:homepick_print/providers/home_page_provider.dart';
import 'package:homepick_print/styles/theme_colors.dart';
import 'package:homepick_print/views/widgets/contact_info.dart';
import 'package:homepick_print/views/widgets/product_item.dart';
import 'package:homepick_print/views/widgets/products_header.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Main Stack For Main Content And Loading Overlay
      body: Stack(
        children: [
          /// Scroll View
          SingleChildScrollView(
            /// Blue Container
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20.0),
              color: Color(0xFF0460B3),

              /// Main Column
              child: Column(
                children: [
                  /// Internal White Container
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),

                    /// Main Column
                    child: Column(
                      children: [
                        /// Top Logo
                        Image.asset('assets/img/homepick-logo.png'),

                        SizedBox(height: 40.0),

                        /// Page Title
                        Text(
                          'INVOICE',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),

                        SizedBox(height: 40.0),

                        /// Contact info of invoice receiver
                        ContactInfo(),

                        SizedBox(height: 40.0),

                        /// Table headings
                        ProductsHeader(),

                        /// Rows containing Details of Products
                        for (int i = 0;
                            i <
                                context
                                    .watch<HomePageProvider>()
                                    .products
                                    .length;
                            i++)
                          ProductItem(productIndex: i),

                        SizedBox(height: 40.0),

                        /// Total Amount Section
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Row(
                            children: [
                              Expanded(child: SizedBox()),
                              Expanded(child: SizedBox()),
                              Expanded(
                                child: Text(
                                  'TOTAL AMOUNT',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  context
                                      .watch<HomePageProvider>()
                                      .getTotalAmount()
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40.0),

                        /// Add Product Button
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomePageProvider>().addProduct(Product(
                                  name: '',
                                  qty: 0,
                                  price: 0.0,
                                ));
                          },
                          child: Text('ADD PRODUCT'),
                        ),

                        SizedBox(height: 40.0),

                        /// Footer with office details and office contact info
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'OFFICE ADDRESS',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    '15 Carlibar Road\nBarrhead, G781AA',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'CONTACT NUMBER',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  '0800 0141 302',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.0),

                  /// Print Button
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => ThemeColors.themeGreen),
                    ),
                    onPressed: () {
                      prepareAndPrintReceipt(context.read<HomePageProvider>());
                    },
                    child: Text('PRINT'),
                  ),

                  SizedBox(height: 40.0),

                  /// Email Section
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      children: [
                        /// Email Heading
                        Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(height: 40.0),

                        /// Row for left alignment
                        Row(
                          children: [
                            /// Certificate Heading
                            Text(
                              'Certificate',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),

                        /// Radio buttons row
                        Row(
                          children: [
                            Radio(
                              value: '10',
                              groupValue: context
                                  .watch<HomePageProvider>()
                                  .certificateYears,
                              onChanged: (value) => context
                                  .read<HomePageProvider>()
                                  .certificateYears = value,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              '10 years',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Radio(
                              value: '15',
                              groupValue: context
                                  .watch<HomePageProvider>()
                                  .certificateYears,
                              onChanged: (value) => context
                                  .read<HomePageProvider>()
                                  .certificateYears = value,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              '15 years',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Radio(
                              value: 'none',
                              groupValue: context
                                  .watch<HomePageProvider>()
                                  .certificateYears,
                              onChanged: (value) => context
                                  .read<HomePageProvider>()
                                  .certificateYears = value,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'No Certificate',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40.0),

                        /// Row for expanding width of container
                        Row(
                          children: [
                            /// To Heading
                            Text(
                              'To:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),

                        /// Recipient Email Inputs List
                        for (int i = 0;
                            i <
                                context
                                    .watch<HomePageProvider>()
                                    .recipients
                                    .length;
                            i++)
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                  onChanged: (value) => context
                                      .read<HomePageProvider>()
                                      .updateRecipient(value, i),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<HomePageProvider>()
                                    .removeRecipient(i),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0)))),
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.red),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 20.0),

                        /// Add Recipient Button
                        ElevatedButton.icon(
                          label: Text('Add Recipient'),
                          onPressed: () {
                            context.read<HomePageProvider>().addRecipient();
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith((states) =>
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50.0)))),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => ThemeColors.themeGreen),
                          ),
                          icon: Icon(
                            Icons.add,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20.0),

                        /// Send Mail Button
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => ThemeColors.themeGreen),
                          ),
                          onPressed: () {
                            prepareAndSendEmail(
                                context.read<HomePageProvider>(), context);
                          },
                          child: Text('Send Mail'),
                        ),
                      ],
                    ),
                  ),

                  /// Debug Text
                  Text(context.watch<HomePageProvider>().debug),
                ],
              ),
            ),
          ),

          /// Loading Overlay
          if (context.read<HomePageProvider>().loading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withAlpha(150),

              /// Center Loader
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue[900],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void prepareAndPrintReceipt(HomePageProvider homePageProvider) async {
    try {
      String html = await prepareHtml(homePageProvider, false);
      html = html.replaceFirst('homepick-logo.png',
          'https://home-pick.co.uk/wp-content/uploads/2021/05/homepick-logo.png');
      String htmlFileName = 'receipt.html';

      await saveFile(htmlFileName, html);

      OpenFile.open(await getFilePath(htmlFileName));
    } catch (e) {
      homePageProvider.debug = e.toString();
    }
  }

  void prepareAndSendEmail(
      HomePageProvider homePageProvider, BuildContext context) async {
    var emailResultMessage = "Email couldn't be sent.";
    try {
      homePageProvider.loading = true;
      String html = await prepareHtml(homePageProvider, true);
      html = html.replaceFirst('homepick-logo.png',
          'https://home-pick.co.uk/wp-content/uploads/2021/05/homepick-logo.png');
      var report = await sendMail(
        html,
        homePageProvider.recipients,
        homePageProvider.certificateYears == '15'
            ? 'certificate-15y.jpeg'
            : homePageProvider.certificateYears == '10'
                ? 'certificate-10y.jpeg'
                : null,
      );
      homePageProvider.loading = false;
      print('Report: ' + report.toString());

      if (report.toString().contains('successfully')) {
        emailResultMessage = 'Email Sent Successfully.';
      }
    } catch (e) {
      homePageProvider.loading = false;
      homePageProvider.debug = e.toString();
    } finally {
      /// Dialog to show email sending result
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(emailResultMessage),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => ThemeColors.themeGreen),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  Future<String> prepareHtml(
      HomePageProvider homePageProvider, bool isEmail) async {
    String mainHtml = await loadAsset(
        'assets/html/${isEmail ? 'email-page' : 'print-page'}.html');
    String productHtml = await loadAsset(
        'assets/html/${isEmail ? 'email-product' : 'product'}.html');
    mainHtml = mainHtml.replaceFirst(
        'issued-to-placeholder', homePageProvider.issuedTo);
    mainHtml = mainHtml.replaceFirst(
        'contact-no-placeholder', homePageProvider.contact);
    mainHtml =
        mainHtml.replaceFirst('email-placeholder', homePageProvider.email);
    mainHtml =
        mainHtml.replaceFirst('address-placeholder', homePageProvider.address);
    mainHtml = mainHtml.replaceFirst('grand-total-placeholder',
        homePageProvider.getTotalAmount().toString());
    String productsHtml = '';

    homePageProvider.products.forEach((product) {
      productsHtml += productHtml
          .substring(0)
          .replaceFirst('product-name-placeholder', product.name)
          .replaceFirst('qty-placeholder', product.qty.toString())
          .replaceFirst('product-price-placeholder', product.price.toString())
          .replaceFirst('total-placeholder',
              (product.price.toInt() * product.qty).toString());
    });

    return mainHtml.replaceFirst('products-placeholder', productsHtml);
  }

  Future<void> saveFile(String fileName, String content) async {
    File file = await File(await getFilePath(fileName)).create();
    await file.writeAsString(content);
  }

  Future<String> getFilePath(String fileName) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    var slash = getPlatformSlash();

    String filePath = '$appDocumentsPath$slash$fileName';

    return filePath;
  }

  String getPlatformSlash() => Platform.isWindows ? '\\' : '/';

  Future<String> loadAsset(fileName) async {
    return await rootBundle.loadString(fileName);
  }

  Future<ByteData> loadByteDataAsset(fileName) async {
    return await rootBundle.load(fileName);
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.jpeg';
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<SendReport> sendMail(
      String body, List<String> recipients, String certificateName) async {
    recipients.removeWhere((element) =>
        element == null ||
        element.isEmpty ||
        !element.contains('@') ||
        !element.contains('.'));
    return await send(
      Message()
        ..html = body
        ..subject = 'Home Pick Invoice'
        ..recipients = recipients
        ..from = 'info@home-pick.co.uk'
        ..attachments = [
          if (certificateName != null)
            // FileAttachment(
            //   File(
            //       'assets${getPlatformSlash()}img${getPlatformSlash()}$certificateName'),
            // ),
            FileAttachment(
              await writeToFile(
                await loadByteDataAsset(
                  'packages${getPlatformSlash()}homepick_print${getPlatformSlash()}assets${getPlatformSlash()}img${getPlatformSlash()}$certificateName',
                ),
              ),
            ),
        ],
      SmtpServer(
        'mail.home-pick.co.uk',
        port: 465,
        username: 'info@home-pick.co.uk',
        password: 'madina9212!',
        ssl: true,
        ignoreBadCertificate: true,
      ),
    );
  }
}

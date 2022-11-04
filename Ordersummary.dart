
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:untitled13/confirmorder.dart';
import 'package:untitled13/google.dart';

import 'package:uuid/uuid.dart';
class Ordersummary extends StatefulWidget {
  @override
  State<Ordersummary> createState() => _OrdersummaryState();
}
class _OrdersummaryState extends State<Ordersummary> {
  var _razorpay = Razorpay();
  int sum = 0;

  late User? user;
  late final Stream<QuerySnapshot> addtocartStream;
  late CollectionReference addcart;
  var area = "";

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('Payment Done');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment fails');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;
    addtocartStream = FirebaseFirestore.instance
        .collection('usersell')
        .doc(user?.uid)
        .collection("addcart")
        .snapshots();
    addcart = FirebaseFirestore.instance.collection('addcart');
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getTotal();
    super.initState();
  }

  var c = '';

  Future getTotal() async {
  //  var a = int.parse('price');
    FirebaseFirestore.instance.collection('usersell').doc(user?.uid).collection(
        'addcart').get().then(
          (querySnapshot) {
        querySnapshot.docs.forEach((result) {
          setState(() {
            sum += int.parse(result.data()['price']) as int;

            c = '${sum}';
          });
          //  sum = (sum + result.data()['price'].add) ;
        });
       // super.initState();

       // print('total : $sum');
      },
    );
  }
  Future<void> order(product) async {
    var uuid = Uuid();
    final curUuid = uuid.v1();
    final _auth = FirebaseAuth.instance;
    print(_auth.currentUser?.uid);

    CollectionReference usersell = FirebaseFirestore.instance.
    collection('order');
    usersell.doc().set({
'ide':sum.toString()+_auth.currentUser!.uid.toString(),

    //  "id":_auth.currentUser?.uid,
"name":_nameController.text,
      "phone":_phoneController.text,
        "Area": _areaController.text,
        "City": _cityController.text,
        "State": selected,
        "Pincode": _pinController.text,
      "email":_auth.currentUser?.email,
   //   "phone":_auth.currentUser?.phoneNumber,
      "Total":sum.toString(),
     // "email":_auth.currentUser?.email,
    //  "phone":_auth.currentUser?.phoneNumber,
      "date":DateTime.now().toString(),
    "Brand":product.map((product)=>product['brand'],).toList(),
      "Model":product.map((product)=>product['model'],).toList(),
      "Price":product.map((product)=>product['price'],).toList(),
    }

    );
    CollectionReference usersel = FirebaseFirestore.instance.
    collection('usersell').doc(_auth.currentUser?.uid).collection('orderr');
    usersel.doc().set({
      'ide':sum.toString()+_auth.currentUser!.uid.toString(),

      //  "id":_auth.currentUser?.uid,
      "name":_nameController.text,
      "phone":_phoneController.text,
      "Area": _areaController.text,
      "City": _cityController.text,
      "State": selected,
      "Pincode": _pinController.text,
      "email":_auth.currentUser?.email,
      //   "phone":_auth.currentUser?.phoneNumber,
      "Total":sum.toString(),
      // "email":_auth.currentUser?.email,
      //  "phone":_auth.currentUser?.phoneNumber,
      "date":DateTime.now().toString(),
      "Brand":product.map((product)=>product['brand'],).toList(),
      "Model":product.map((product)=>product['model'],).toList(),
      "Price":product.map((product)=>product['price'],).toList(),
    }

    );

    // print('User added');

  }
  sendi(product,selected) async {
    final _auth = FirebaseAuth.instance;

    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.
    String username = 'vivekp@evdock.app';
    String password = 'ibttscdrcgydlsik';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Vivek Prajapati')
      ..recipients.add('vivekp@evdock.app')
   ..ccRecipients.addAll([_auth.currentUser?.email])
    //  ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = sum.toString()+_auth.currentUser!.uid.toString()
     // ..text='Order id,'+sum.toString()+_auth.currentUser!.uid.toString()
    //..text = product.map((product)=>product['brand'],).toList()
   //   ..text = product.map((product)=>product['model'],).toList()
    //  ..text = product.map((product)=>product['price'],).toList()
    //  ..text = sum.toString()
     ..text = 'Your order has been confirm!'+'\n\n'
         +"Name:       "+_nameController.text+'\n'+
    "Phone:     "+_phoneController.text+'\n'+
    "Addrese:  "+ _areaController.text+','+'\n'+
               '                 '+  _cityController.text+','+'\n'+
              '                 '+  selected+'-'
          +   _pinController.text+'\n\n'+
'Order No:'+sum.toString()+_auth.currentUser!.uid.toString()+"\n\n"+
    'Details:'+'\n'+product.map((product)=>product['brand'],).toString()+"\n"+

         product.map((product)=>product['model'],).toString()+"\n"+

         product.map((product)=>product['price'],).toString()+'\n\n'+'Total Price:  '+

      'Rs'+   sum.toString()+'/-';


   // ..text = 'This is the plain text.\nThis is line 2 of the text part.';
//  ..html = "<h1>_pinController.text</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${e}: ${p.msg}');
      }
    }


  }
  clearText(){
    _pinController.clear();
  _cityController.clear();
    // _imageController.clear();
   _areaController.clear();

  }
   // Future<void> order(data) async {
   //  var uuid = Uuid();
   //  final curUuid = uuid.v1();
   //  final _auth = FirebaseAuth.instance; // print(_auth.currentUser?.uid);
   //  CollectionReference usersell = FirebaseFirestore.instance.
   //   collection('usersell').doc(_auth.currentUser?.uid).collection('order');
   //   usersell.doc(curUuid).set({
  //   'brand': data('brand'),
  //   // 'model': widget.product.get('brand'),
  //   //  'price': widget.product.get('brand'),
  //   // 'image': widget.product.get('image'),
  //   //  "email":_auth.currentUser?.email,
  //   "phone":_auth.currentUser?.phoneNumber,
  //     }).then((value) => print('Product Added'))
  //      .catchError((error) => print('failed to add Product:$error'));
    // // final collection = await FirebaseFirestore.instance
    //   .collection("order");
    // collection.doc().set({
    // CollectionReference order = FirebaseFirestore.instance.
    // collection('order');
    //  order.doc().set(  {
    //  'brand': data['brand'],
    //   'model':  data['model'],
    //  'price': data['price'],
    //   'area':data['_cityController']
    //   "email":_auth.currentUser?.email,
    // 'image': widget.product.get('image'),
    // }).then((valure) => print('Product Added'))
    //     .catchError((error) => print('failed to add Product:$error'));
    // final order = FirebaseFirestore.instance.collection('order');
    //  order.get().then((snapshot) {
    //  snapshot.docs.forEach((doc) {
    // print(doc.data);
    //  });
    // });
    // print('User added');
    //CollectionReference orded = FirebaseFirestore.instance.
    // collection('order');
    // await orded.doc().set(.map());
    //// FirebaseFirestore.instance.collection("order").doc().set({
    //"locationEntry": FieldValue.arrayUnion([data['product']])
    // }
    //  ).then((value) => print('product'));
    //  'brand': widget.product.get('brand'),
    // 'model': widget.product.get('brand'),
    //  'price': widget.product.get('brand'),
    //   "email":_auth.currentUser?.email,
    //  'image': widget.product.get('image'),
    //  ).then((valure) => print('Product Added'))
    //.catchError((error) => print('failed to add Product:$error'));
    // print('User added');
    // }
    //Future<void>order()async {
    // var uuid = Uuid();
    // final curUuid = uuid.v1();
    // final _auth = FirebaseAuth.instance;
    // print(_auth.currentUser?.uid);
    //CollectionReference usersell = FirebaseFirestore.instance.
    //  collection('usersell').doc(_auth.currentUser?.uid).collection('order');
    // usersell.doc(curUuid).set({
    // 'brand': widget.product.get('brand'),
    // 'model': widget.product.get('brand'),
    //  'price': widget.product.get('brand'),
    // 'image': widget.product.get('image'),
    //  "email":_auth.currentUser?.email,
    // "phone":_auth.currentUser?.phoneNumber,
    //  }).then((valure) => print('Product Added'))
    //    .catchError((error) => print('failed to add Product:$error'));
    // CollectionReference usersell = FirebaseFirestore.instance.collection('order');
    // WriteBatch batch = FirebaseFirestore.instance.batch();
    //  final batch = FirebaseFirestore.instance.batch();
//batch.set({

//});
    // CollectionReference order = FirebaseFirestore.instance.
    // collection('order');
    // order.doc().set(  {

    //  'brand': data['brand'],
    //  'model':  data['model'],
    //  'price': data['price'],
    //   'area':data['_cityController']
    // "email":_auth.currentUser?.email,
    // 'image': widget.product.get('image'),
    // }).then((valure) => print('Product Added'))
    //    .catchError((error) => print('failed to add Product:$error'));
    // final order = FirebaseFirestore.instance.collection('order');
    //  order.get().then((snapshot) {
    //  snapshot.docs.forEach((doc) {
    // print(doc.data);
    //  });
    // });
    // print('User added');
    //CollectionReference orded = FirebaseFirestore.instance.
    // collection('order').doc(_auth.currentUser?.uid).collection('orderd');
    // orded.doc(curUuid).set({
    //  'brand': widget.product.get('brand'),
    // 'model': widget.product.get('brand'),
    //  'price': widget.product.get('brand'),
    //   "email":_auth.currentUser?.email,
    //  'image': widget.product.get('image'),
    //  }).then((valure) => print('Product Added'))
    //   .catchError((error) => print('failed to add Product:$error'));
    // print('User added');
    //  }
    // Future<void> pdf() async {
    //   UploadTask? uploadTask;
    //   final path = 'files/${Random}';
    //   final file = File('${Random}.pdf');
    //   final ref = FirebaseStorage.instance.ref().child(path);
    //   uploadTask = ref.putFile(file);
    //   final snapshot = await uploadTask;
    //   var url = await snapshot.ref.getDownloadURL();
    //   print(url);
    //   PdfDocument document = PdfDocument();
    //   document.pages.add();
    //  }
  final _formKey =GlobalKey<FormState>();
    final TextEditingController _areaController = new TextEditingController();
    final TextEditingController _cityController = new TextEditingController();
    final TextEditingController _stateController = new TextEditingController();
    final TextEditingController _pinController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
    final ite = [
      "Andhra Pradesh",
      "Arunachal Pradesh",
      "Assam",
      "Bihar",
      "Chhattisgarh",
      "Goa",
      "Gujarat",
      "Haryana",
      "Himachal Pradesh",
      "Jammu and Kashmir",
      "Jharkhand",
      "Karnataka",
      "Kerala",
      "Madhya Pradesh",
      "Maharashtra",
      "Manipur",
      "Meghalaya",
      "Mizoram",
      "Nagaland",
      "Odisha",
      "Punjab",
      "Rajasthan",
      "Sikkim",
      "Tamil Nadu",
      "Telangana",
      "Tripura",
      "Uttarakhand",
      "Uttar Pradesh",
      "West Bengal",
      "Andaman and Nicobar Islands",
      "Chandigarh",
      "Dadra and Nagar Haveli",
      "Daman and Diu",
      "Delhi",
      "Lakshadweep",
      "Puducherry"
    ];
    String? selected = 'Maharashtra';
    // const ProductList({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(stream: addtocartStream,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot>snapshot) {
            if (snapshot.hasError) {
              print("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
              );
            }
             List product = [];
            snapshot.data!.docs.map((DocumentSnapshot document) async {
              Map a = document.data() as Map<String, dynamic>;
              product.add(a);
              a['id'] = document.id;
            }).toList();
//print(product);
            return Scaffold(
                appBar: AppBar(
                  title:   Text('Order Summary', textAlign: TextAlign.center,
                      style:GoogleFonts.aleo(textStyle: TextStyle(color: Colors.white))),
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.white),
                  backgroundColor:  Color.fromARGB(255,0 , 18, 50),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 50,
                    width: 360,
                    child: FloatingActionButton
                      (
                      backgroundColor: const Color.fromARGB(255, 43, 72, 101),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Draweer() )),
                      //  sendmail();
                        valid(product);


                    //  order(product);
                        //  batchDelete();
                        // var options = {
                        // 'key': "rzp_test_7IfIOEdRf43ynv",
                        // 'amount': sum, //in the smallest currency sub-unit.
                        // 'name': 'Tritan Group',
                        // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                        // 'description': '',
                        // 'timeout': 300, // in seconds
                        // 'prefill': {
                        //  'contact': '9903910391',
                        //  'email': 'vivekp@evdock.app'
                        //  }
                        // };
                        //
                        // _razorpay.open(options);
//print(product);
                        // setState(()
                        //  {
                        //  area=_areaController.text;
// //pdf();
//                    order();
//                          product.map((e) => {
//                         order(e)
//                          });


                        // _uploadImage();
                        //   addUser();
//clearText();
                        //  Fluttertoast.showToast(msg: "Bikes Posted");
                        // Navigator.of(context).pop(Sellpanelupload);
                        //  });
                      },


                      // print(product[0]['id']);
                      // setState(() {
                      //  delete(product[0]['id']);
                      //  });

                      // order();
                      // delete();

                      child: Text('Check Out'),


                    ),
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation
                    .centerDocked,
                body: SingleChildScrollView(
                  child: Form(
                    // key: _formKey,
                    child: Column(

                        children: [

                          Padding(
                            padding: const EdgeInsets.fromLTRB(13, 8, 13, 8),
                            child: Table(
                              columnWidths: {
                                0: FlexColumnWidth(1.6),
                                1: FlexColumnWidth(3),

                                2: FlexColumnWidth(1.9),
                                //  2: FlexColumnWidth(4),
                              },
                              border: TableBorder.symmetric(outside: BorderSide(
                                  width: 2,
                                  color:   Color.fromARGB(255,0 , 18, 50),),),
                              children: [
                                TableRow(
                                    children: [
                                      Text(''),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            13, 8, 13, 8),
                                        child:
                                        Text('Product'+'\n', style: GoogleFonts.signika(textStyle: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.w500,color: Color.fromARGB(255,0 , 18, 50) )),),

                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            13, 8, 13, 8),
                                        child:
                                        Text('Price' + '\n', style: GoogleFonts.signika(textStyle: TextStyle(


                                      ),
                                            fontSize: 20, fontWeight: FontWeight.w500,color: Color.fromARGB(255,0 , 18, 50) )),),

                                    ]
                                ),

                                for (var i = 0; i < product.length; i++) ...[
                                  TableRow(
                                      children: [
                                        Image.network(
                                          product[i]['image'], width: 100,
                                          height: 55,)
                                        , Padding(
                                          padding: const EdgeInsets
                                              .fromLTRB(13, 5, 13, 5),
                                          child: Text(
                                              product[i]['brand'] + '\n' +
                                                  product[i]['model'] + '\n',
                                              style: TextStyle(fontSize: 16,
                                                  fontWeight: FontWeight
                                                      .w400)),

                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              13, 5, 13, 5),
                                          child: Text(
                                              'Rs' + product[i]['price'] + '/-',
                                              style: TextStyle(fontSize: 16,
                                                  fontWeight: FontWeight.w400)),
                                        )
                                      ]
                                  ),
                                ]
                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Row(
                              children: [

                                Text('Total Price:  ', style: GoogleFonts.signika(textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500,color: Color.fromARGB(255,0 , 18, 50) )),),


                                SizedBox(
                                  width: 68,
                                ),

                                Text('Rs  ' + sum.toString() + '/-',
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),

                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    children: [
                                      Text('Buyer Detail*', style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: TextFormField(
                                    controller: _nameController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    minLines: 1,
                                    maxLines: 3,

                                    decoration: InputDecoration(

                                      // fillColor: Colors.grey.shade100,
                                      //filled: true,
                                      hintText: 'Enter full name ',

                                      hintStyle: const TextStyle(
                                          height: 2, fontWeight: FontWeight.bold),

                                    ),

                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter full name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: _phoneController,
                                    keyboardType: TextInputType.number,
                                    onSaved: (value){
                                      _phoneController.text=value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          height: 2, fontWeight: FontWeight.bold),


                                      hintText: "Phone Number",

                                    ),
                                    validator: (value){
                                      if(value==null||value.isEmpty)
                                      {
                                        return "Enter your phone number";
                                      }
                                      if(value.length>10||value.length<10)
                                      {
                                        return "Enter your valid phone number";
                                      }

                                      return null;
                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Row(
                                    children: [
                                      Text('Shipping Addrese*', style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: TextFormField(
                                      controller: _areaController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.streetAddress,
                                      minLines: 1,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        // fillColor: Colors.grey.shade100,
                                        //filled: true,
                                        hintText: 'Enter street & area name ',

                                        hintStyle: const TextStyle(
                                            height: 2, fontWeight: FontWeight.bold),

                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: TextFormField(
                                      controller: _cityController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.streetAddress,
                                      maxLines: 1,

                                      decoration: InputDecoration(
                                        // fillColor: Colors.grey.shade100,
                                        //  filled: true,
                                        hintText: 'Enter city name',
                                        hintStyle: const TextStyle(
                                            height: 2, fontWeight: FontWeight.bold),

                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Plese enter Landmark';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 45,
                                  child: Container(
                                    width: 360,

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton<String>(
                                        isExpanded: true,

                                        value: selected,
                                        items: ite.map((ite) =>
                                            DropdownMenuItem<String>(
                                              value: ite,

                                              child: Text(
                                                  ite, style: TextStyle(fontSize: 20)
                                              )
                                              ,))
                                            .toList(),
                                        onChanged: (items) =>
                                            setState(() => selected = items),),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: TextFormField(
                                      controller: _pinController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,

                                      decoration: InputDecoration(
                                        // fillColor: Colors.grey.shade100,
                                        // filled: true,
                                        hintText: 'Pincode',
                                        hintStyle: const TextStyle(
                                            height: 2, fontWeight: FontWeight.bold),

                                      ),
                                      // The validator receives the text that the user has entered.
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter pincode';
                                        }
                                          if (value.length>6||value.length<6) {
                                         return 'Enter valid Pincode';
                                           }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            ),

                          ),


                          /* Container(
                              child: Expanded(
                                child: ListView.builder(
                                itemCount:   snapshot.data!.docs.length,

                                itemBuilder: (context,index){
                                  final  product = snapshot.data!.docs[index];
                                  return Container(

                                    child: Card(
                                      child:

                                      ListTile(

                                        leading: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                minWidth: 100,
                                                minHeight: 260,
                                                maxWidth: 104,
                                                maxHeight: 264
                                            ),


                                            child: Image.network(product.get('image'))),
                                        title: Text(product.get('brand'),style: TextStyle(fontSize: 20),),
                                        subtitle: Text(product.get('model'),style: TextStyle(fontSize: 15),),
                                        trailing: Text('Rs '+product.get('price')+'/-',style: TextStyle(fontSize: 15),),

                                      ),
                                    ),


                                  );



                                }),
                              ),
                            ),*/
                        ]
                    ),
                  ),
                )
            );
          }
      );
    }
    @override
    void dispose() {
      _razorpay.clear(); // Removes all listeners
      super.dispose();
    }

  void valid(List product) {
      if(_formKey.currentState!.validate()){
     order(product);
     sendi(product,selected);
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ConfirmOrder() ));

      }

    // if(_formKey.currentState!.validate()){
    //   await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
    //     order(product);
    //   }).catchError((e)
    //   {
    //     Fluttertoast.showToast(msg: e!.message);
    //   }
    //   );
    //
    // }
  }
  //
  // Future sendmail() async {
  //
  //  final user= await GoogleAuthApi.signIn();
  //     if(user == null)return;
  //
  //   final auth=await user.authentication;
  //       final token=auth.accessToken;
  //     final email=user.email;
  //
  //     final smtpServer=gmailRelaySaslXoauth2(email,'token');
  //
  //     final message=Message()
  //     ..from=Address(email,token)
  //         ..subject="Hello"
  //         ..text="Email";
  //
  //     try{
  //
  //       await send(message, smtpServer);
  //
  //     }on MailerException catch(e){
  //       print(e);
  //     }
  //
  //
  // }
  //
   }


// }


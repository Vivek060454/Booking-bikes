import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
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
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';
class Rent extends StatefulWidget {

  @override
  State<Rent> createState() => _RentState();
}
class _RentState extends State<Rent> {

  late User? user;
  late final Stream<QuerySnapshot> addtocartStream;
  late CollectionReference addcart;
  var area = "";

String r='250';

  String s='250';






  var brand = null;
  var price = null;
  Future<void> order() async {
    var uuid = Uuid();
    final curUuid = uuid.v1();
    final _auth = FirebaseAuth.instance;
    print(_auth.currentUser?.uid);

    CollectionReference usersell = FirebaseFirestore.instance.
    collection('Rent_Order');
    usersell.doc().set({
      'ide': s.toString() + _auth.currentUser!.uid.toString(),

      //  "id":_auth.currentUser?.uid,
      "name": _nameController.text,
      "phone": _phoneController.text,
      "From": DateFormat('yyyy/MM/dd').format(dateRange.start),
      "To": DateFormat('yyyy/MM/dd').format(dateRange.end),
      "Pickup": se1e,
      "Drop-off":se2e,
      'Type':'Primary Bikes',
      'Days':dateRange.duration.inDays+1,

      'Locat': selected,
      "email": _auth.currentUser?.email,
      //   "phone":_auth.currentUser?.phoneNumber,
      "Total Price": s.toString(),
      // "email":_auth.currentUser?.email,
      //  "phone":_auth.currentUser?.phoneNumber,
      "date": DateTime.now().toString(),
    }

    );
    CollectionReference usersel = FirebaseFirestore.instance.
    collection('usersell').doc(_auth.currentUser?.uid).collection('Rent_orderr');
    usersel.doc().set({
     'ide':s.toString()+_auth.currentUser!.uid.toString(),

      //  "id":_auth.currentUser?.uid,
      "name":_nameController.text,
      "phone":_phoneController.text,
      "From": DateFormat('yyyy/MM/dd').format(dateRange.start),
      "To":  DateFormat('yyyy/MM/dd').format(dateRange.end),
      "Pickup": se1e,
      "Drop-off":se2e,
      'Type':'Primary Bikes',
      'Days':dateRange.duration.inDays+1,
 
'Locat':selected,
      "email":_auth.currentUser?.email,

      //   "phone":_auth.currentUser?.phoneNumber,
      "Total Price":s.toString(),
      // "email":_auth.currentUser?.email,
      //  "phone":_auth.currentUser?.phoneNumber,
      "date":DateTime.now().toString(),

    }

    );

    // print('User added');

  }
  sendi(selected) async {
    final _auth = FirebaseAuth.instance;

    // Note that using a username and pazssword for gmail only works if
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
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    //  ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'For Bikes Rent'
    // ..text='Order id,'+sum.toString()+_auth.currentUser!.uid.toString()
    //..text = product.map((product)=>product['brand'],).toList()
    //   ..text = product.map((product)=>product['model'],).toList()
    //  ..text = product.map((product)=>product['price'],).toList()
    //  ..text = sum.toString()
      ..text = 'For Rent Primary Bikes!'+'\n\n'
          +"Name   :  "+_nameController.text+'\n'+
          "Phone   :  "+_phoneController.text+'\n'+
          "Location:  "+ selected+'\n\n'+
          'From    :  '+  DateFormat('yyyy/MM/dd').format(dateRange.start)+'\n'+
          'To      :  '+ DateFormat('yyyy/MM/dd').format(dateRange.end)+'\n\n'+
          'Pickup Time   :  '+ se1e.toString()+'\n'+
          'Drop-off Time :  '+ se2e.toString()+'\n\n'+
          'Id:'+s.toString()+_auth.currentUser!.uid.toString()+'\n\n'+
          'Total Price:'+s.toString()+"\n\n";


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
    _nameController.clear();
    _monthController.clear();
    // _imageController.clear();
    _phoneController.clear();

  }

  final _formKey =GlobalKey<FormState>();
  final TextEditingController _areaController = new TextEditingController();
  final TextEditingController _monthController = new TextEditingController();
  final TextEditingController _cityController = new TextEditingController();
  final TextEditingController _stateController = new TextEditingController();
  final TextEditingController _pinController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _nameController = new TextEditingController();
  final ite = [
    'Goa',
    'Thane'
  ];
  String? selected = 'Thane';
  final se1 = [
    '10:00AM','10:30AM','11:00AM','11:00AM','11:30AM','12:00PM','12:30PM','01:00PM','01:30PM',
    '02:00PM','02:30PM','03:00PM','03:30PM','04:00PM','04:30PM','05:00PM','05:30PM','06:00PM',
    '06:30PM','07:00PM','07:30PM','08:00PM',

  ];
  String? se1e = '10:00AM';
  final se2 = [
    '10:00AM','10:30AM','11:00AM','11:00AM','11:30AM','12:00PM','12:30PM','01:00PM','01:30PM',
    '02:00PM','02:30PM','03:00PM','03:30PM','04:00PM','04:30PM','05:00PM','05:30PM','06:00PM',
    '06:30PM','07:00PM','07:30PM','08:00PM',

  ];
  String? se2e = '10:00AM';
  final items = [
    '10:00AM','10:30AM','11:00AM','11:00AM','11:30AM','12:00PM','12:30PM','01:00PM','01:30PM',
    '02:00PM','02:30PM','03:00PM','03:30PM','04:00PM','04:30PM','05:00PM','05:30PM','06:00PM',
    '06:30PM','07:00PM','07:30PM','08:00PM',

  ];
  String? selectedItem = '10:00AM';

  // const ProductList({Key? key}) : super(key: key);
  DateTimeRange dateRange=DateTimeRange(
  start:DateTime.now(),
   end: DateTime.now())
  ;
  @override
  Widget build(BuildContext context) {
    final start=dateRange.start;
    final end =dateRange.end;
    final difference=dateRange.duration;




          return Scaffold(
              appBar: AppBar(
                title:   Text('Primary Bikes', textAlign: TextAlign.center,
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
             valid();


                    },




                    child: Text('Proceed To Pay'),


                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation
                  .centerDocked,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      // key: _formKey,
                      child: Column(

                          children: [


Container(
  decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 43, 72, 101)),
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
    ),

   // color:   Color.fromARGB(255,0 , 18, 50),
  ),
  child:   Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(

      children: [

        Padding(

          padding: const EdgeInsets.only(top: 0,bottom: 0,left: 5,right: 5),

          child: Row(

            children: [

              Text('Select Date *', style: GoogleFonts.signika(textStyle: TextStyle(

                  fontSize: 22, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 43, 72, 101) )),),

            ],

          ),

        ),

            Padding(

              padding: const EdgeInsets.only(top: 0,bottom: 0,left: 8,right: 8),

              child: Row(

          children: [

              Text('From:  ${DateFormat('yyyy/MM/dd').format(start)}',style: TextStyle(

                    fontWeight: FontWeight.w500,

                    fontSize: 20),),


              IconButton(color:Color.fromARGB(255, 43, 72, 101),onPressed: (){
setState(() {

  pickDateRange();
});
}, icon: Icon(Icons.calendar_month_outlined))

          ],

        ),

            ),



        Padding(

          padding: const EdgeInsets.only(top: 0,bottom: 0,left: 8,right: 8),

          child: Row(

            children: [

              Text('TO    :  ${DateFormat('yyyy/MM/dd').format(end)}',style: TextStyle(

                    fontWeight: FontWeight.w500,

                    fontSize: 20),),

              IconButton(color:Color.fromARGB(255, 43, 72, 101),onPressed: (){
setState(() {
  pickDateRange();
});
               }, icon: Icon(Icons.calendar_month_outlined))

            ],

          ),

        ),
        Table(
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),


          },

          children: [
            TableRow(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 0,bottom: 0,left: 13,
                        right: 13),
                    child: Container(


                      child: Text('Pickup Time ',style: TextStyle(

                          fontWeight: FontWeight.w500,

                          fontSize: 20,color: Colors.black26),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2,bottom: 2,left: 13,
                        right: 13),
                    child: Container(


                      child: Text('Drop-off Time',style: TextStyle(

                          fontWeight: FontWeight.w500,

                          fontSize: 20,color: Colors.black26),),
                    ),
                  ),


                ]
            ),
            TableRow(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 2,bottom: 8,left: 13,
                        right: 13),
                    child: Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 130,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value:se1e,
                              items: se1.map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,

                                    child: Text(item, style: TextStyle(fontSize: 20)
                                    )
                                    ,))
                                  .toList(),
                              onChanged: (items) =>
                                  setState(() => se1e = items),),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const  EdgeInsets.only(top: 2,bottom: 8,left: 13,
                        right: 13),
                    child: Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 130,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value:se2e,
                              items: se2.map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,

                                    child: Text(item, style: TextStyle(fontSize: 20)
                                    )
                                    ,))
                                  .toList(),
                              onChanged: (items) =>
                                  setState(() => se2e = items),),
                          ),
                        ),
                      ),
                    ),
                  ),


                ]
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
          child: Row(
            children: [
              Text('Select Store *', style: GoogleFonts.signika(textStyle: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 43, 72, 101) )),),
            ],
          ),
        ),
        SizedBox(
          height: 45,
          child: Container(
            width: 360,

            child: Row(
              children: [Text('Bikes for rent in', style: GoogleFonts.signika(textStyle: TextStyle(
                fontSize:20 , fontWeight: FontWeight.w400, )),),

                SizedBox(
                  height: 50,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: Container(
                        height: 1,
                        color: Color.fromARGB(255, 43, 72, 101) //<-- SEE HERE
                      ),
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
              ],
            ),
          ),
        ),


      ],

    ),
  ),
),

                        //   mainAxisAlignment: MainAxisAlignment.center,
                           //   children: [
                           //
                           //     Expanded(child: ElevatedButton(
                           //       child: Text(DateFormat('yyyy/MM/dd').format(start)),
                           //       onPressed: (){
                           //         pickDateRange();
                           //       },
                           //     )),
                           //     SizedBox(width: 20,),
                           //     Expanded(child: ElevatedButton(
                           //       child: Text(DateFormat('yyyy/MM/dd').format(end)),
                           //       onPressed: (){},
                           //     )),
                           //   ],
                           // ),
                           //  Text('Diffrence: ${difference.inDays+1}day'),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [

                               
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 5,left: 5,right: 5),
                                    child: Row(
                                      children: [
                                        Text('Details*', style: GoogleFonts.signika(textStyle: TextStyle(
                                            fontSize: 22, fontWeight: FontWeight.w400,color: Color.fromARGB(255, 43, 72, 101) )),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2,bottom: 2,left: 13,right: 13),
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
                                    padding: const  EdgeInsets.only(top: 2,bottom: 2,left: 13,right: 13),
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
  padding: const EdgeInsets.all(8.0),
  child:   Row(
    children: [
          Container(

        child:
        Text('Total Price  : Rs${s}/-',style: GoogleFonts.signika(textStyle: TextStyle(

            fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) ))),

      ),
    ],
  ),
),







// Padding(
//   padding: const EdgeInsets.all(13.0),
//   child:   Row(
//
//     children: [
//
//  if(  widget.product.get('pr')=='0k-10k')...[
//
//
//      sum=   Text('Total  : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='10k-20k')...[
//         sum=     Text('Total Price  : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='20k-30k')...[
//         sum=    Text('Total Price : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='30k-40k')...[
//         sum=    Text('Total Price : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='40k-50k')...[
//         sum=    Text('Total Price : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='50k-60k')...[
//         sum=    Text('Total Price : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='60k-70k')...[
//         sum=   Text('Total Price : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='70k-80k')...[
//         sum=    Text('Total Price : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='80k-90k')...[
//         sum=    Text('Total Price : RS${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='90k-100k')...[
//         sum=     Text('Total Price : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//       if(  widget.product.get('pr')=='100k-nk')...[
//      sum=   Text('Total Price : Rs${((difference.inDays+1)*0.03*int.parse( widget.product.get('price'))).toStringAsFixed(0)}/-'
//           ,style: GoogleFonts.signika(textStyle: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) )),)
//       ],
//
//
//     ],
//
//   ),
//
// ),


                                       SizedBox(
                                         height: 50,
                                       )      // Row(

                                  // Padding(
                                  //   padding: const EdgeInsets.all(13.0),
                                  //   child: Row(
                                  //     children: [
                                  //       Text('Addrese*', style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           fontSize: 16),),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 80,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(13.0),
                                  //     child: TextFormField(
                                  //       controller: _areaController,
                                  //       textInputAction: TextInputAction.next,
                                  //       keyboardType: TextInputType.streetAddress,
                                  //       minLines: 1,
                                  //       maxLines: 3,
                                  //       decoration: InputDecoration(
                                  //         // fillColor: Colors.grey.shade100,
                                  //         //filled: true,
                                  //         hintText: 'Enter street & area name ',
                                  //
                                  //         hintStyle: const TextStyle(
                                  //             height: 2, fontWeight: FontWeight.bold),
                                  //
                                  //       ),
                                  //       // The validator receives the text that the user has entered.
                                  //       validator: (value) {
                                  //         if (value == null || value.isEmpty) {
                                  //           return 'Please enter name';
                                  //         }
                                  //         return null;
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  //
                                  // SizedBox(
                                  //   height: 80,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(13.0),
                                  //     child: TextFormField(
                                  //       controller: _cityController,
                                  //       textInputAction: TextInputAction.next,
                                  //       keyboardType: TextInputType.streetAddress,
                                  //       maxLines: 1,
                                  //
                                  //       decoration: InputDecoration(
                                  //         // fillColor: Colors.grey.shade100,
                                  //         //  filled: true,
                                  //         hintText: 'Enter city name',
                                  //         hintStyle: const TextStyle(
                                  //             height: 2, fontWeight: FontWeight.bold),
                                  //
                                  //       ),
                                  //       // The validator receives the text that the user has entered.
                                  //       validator: (value) {
                                  //         if (value == null || value.isEmpty) {
                                  //           return 'Plese enter Landmark';
                                  //         }
                                  //         return null;
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  //
                                  //
                                  // SizedBox(
                                  //   height: 80,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(13.0),
                                  //     child: TextFormField(
                                  //       controller: _pinController,
                                  //       textInputAction: TextInputAction.next,
                                  //       keyboardType: TextInputType.number,
                                  //
                                  //       decoration: InputDecoration(
                                  //         // fillColor: Colors.grey.shade100,
                                  //         // filled: true,
                                  //         hintText: 'Pincode',
                                  //         hintStyle: const TextStyle(
                                  //             height: 2, fontWeight: FontWeight.bold),
                                  //
                                  //       ),
                                  //       // The validator receives the text that the user has entered.
                                  //       validator: (value) {
                                  //         if (value == null || value.isEmpty) {
                                  //           return 'Please enter pincode';
                                  //         }
                                  //         if (value.length>6||value.length<6) {
                                  //           return 'Enter valid Pincode';
                                  //         }
                                  //         return null;
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 100,
                                  // )
                                ],
                              ),

                            ),



                          ]
                      ),
                    ),
                  ),
                ),
              )
          );
        }

  @override

  void valid() {
    if(_formKey.currentState!.validate()){



        order();


    sendi(selected);
        clearText();

     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ConfirmOrder() ));

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

Future pickDateRange()async {
    DateTimeRange? newDateRange= await

    showDateRangePicker(context: context
      ,initialDateRange: dateRange, firstDate: DateTime(2022), lastDate: DateTime(2045),);
    if (newDateRange==null)return;
    if (newDateRange.start==DateTime.now()||newDateRange.start.isAfter(DateTime.now())) {
      setState((){dateRange=newDateRange;
    s= ((dateRange.duration.inDays+1)*int.parse(r)).toString();
    print(s);
    print(dateRange.duration.inDays);
// super.dispose();
      });
    } else{
      Fluttertoast.showToast(msg: 'Please select valid date!');
    }
}
void Wi(){
   if (dateRange.duration.inDays!=1){
    r= ((dateRange.duration.inDays+1)*int.parse(r)).toString();
   }

 }



}


import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class RentDetails extends StatefulWidget {

  final produt;
  const RentDetails(this.produt, {Key? key}) : super(key: key);

  @override
  State<RentDetails> createState() => _RentDetailsState();
}


class _RentDetailsState extends State<RentDetails> {


  // static String? get _auth=> null;


  @override


  //const Detailee({Key? key}) : super(key: key);
  // late String s1image;
  //
  // late String image;
  //
  // late String simage;
  //
  // late String brand;
  //
  // late  String description;
  //
  //  var spc1;
  //
  //  late var sellername;
  //
  // late  String city;
  //
  // late var spc2;
  //
  // late int phone;
  //
  // late  String title;
  //
  // late var price;
  //
  // late var spc3;

  @override
  Widget build(BuildContext context) {
    // final Detailee=ProductC(id: widget.productl.id, phone: widget.productl.phone, brand: widget.product.brand, sellername: widget.product.sellername ,
    //     image: widget.productl.image, simage: widget.product.simage, s1image: widget.productl.s1image, spc1: widget.product.spc1, spc2: widget.product.spc2,
    //     spc3: widget.productl.spc3, city: widget.productl.city, title: widget.product.title, price: widget.product.price, description: widget.product.description) ;
    return Scaffold(
      appBar: AppBar(
        title:   Text('Rent Order Details', textAlign: TextAlign.center,
            style:GoogleFonts.aleo(textStyle: TextStyle(color: Colors.white))),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor:  Color.fromARGB(255,0 , 18, 50),
        //backgroundColor: Color.fromRGBO(100, 0,0 , 10),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 3,
                  color:  Color.fromARGB(255,0 , 18, 50)
              ),

            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(4),
                      //  2: FlexColumnWidth(4),
                    },


                    //  border: TableBorder(verticalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),

                    children: [

                      TableRow(
                          children: [
                            SizedBox(
                                height:100,
                                width: 100,
                                child: Image.asset("assets/Tritan-removebg-preview (1).png")),

                            Text("")
                          ]
                      ),



                    ],
                  ),

                  Divider(
                    height: 5,
                    thickness: 5,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(4),
                      //  2: FlexColumnWidth(4),
                    },


                    //   border: TableBorder(verticalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),

                    children: [



                      TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Tritan Bikes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),textAlign: TextAlign.start,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text("102 Suryavihar Building\nService Road , Pancphkhadi\nThane – 400602\nE-mail – tritanbikes@gmail.com")

                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [

                                  Row(
                                    children: [
                                      Text("Rent Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(widget.produt.get('name',),textAlign: TextAlign.left,),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(widget.produt.get('Area',),textAlign: TextAlign.left,),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Text(widget.produt.get('City')),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Text(widget.produt.get('Pincode')),
                                  //   ],
                                  // ),

                                  Row(
                                    children: [
                                      Text(widget.produt.get('email')),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(widget.produt.get('phone')),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(widget.produt.get('Locat')),
                                    ],
                                  ),
                                ],
                              ),
                            ),


                          ]
                      ),



                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("GST:                27ACCPS6887M1ZN"),

                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text("Invoice No:    "+widget.produt.get('ide')),
                        ],
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Text("Date:               "+widget.produt.get('date')),
                    ],
                  ),

                  Divider(
                    height: 20,
                    thickness: 5,
                  ),
                  Row(
                    children: [
                      Text("                   Product",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),
                      SizedBox(
                        width: 160,
                      ),
                      Text("Price",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(2),
                        4: FlexColumnWidth(2),
                      },
                      border: TableBorder(left: BorderSide(color: Colors.grey, width: 3 ), right: BorderSide(color: Colors.grey, width: 3)),
                      children: [
                        const TableRow(
                            children: [
                              Text("Sr No"),
                              Text("Type"),
                              Text('Day'),
                              Text("Amount"),
                              Text("Total Price")


                            ]
                        ),
                        TableRow(
                            children: [
                              //    Image.network(widget.produt.get('Image').),
                              Text('1'),
                              //  Text(widget.produt.get('Brand').toString()),
                              Text(widget.produt.get('Type').toString()),

                              Text(widget.produt.get('Days').toString()),
                              Container(child:widget.produt.get('Type')=='Primary Bikes'?
                              const Text('250',):
                              Text('500')),
                              Text(widget.produt.get('Total Price').toString()),
                            ]
                        ),



                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('From:'+widget.produt.get('From'), style: GoogleFonts.signika(textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) ))),
                      SizedBox(
                        width: 65,
                      ),
                      Text('Pickup:'+widget.produt.get('Pickup'), style: GoogleFonts.signika(textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) ))),
                    ],
                  ),


                  Row(
                    children: [
                      Text('To      :'+widget.produt.get('To'), style: GoogleFonts.signika(textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) ))),
                      SizedBox(
                        width: 65,
                      ),
                      Text('Drop-off:'+widget.produt.get('Drop-off'), style: GoogleFonts.signika(textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400,color: Color.fromARGB(255,0 , 18, 50) ))),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [


                      Text('Total Price:  ', style: GoogleFonts.signika(textStyle: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500,color: Color.fromARGB(255,0 , 18, 50) )),),

                      SizedBox(
                        width: 100,
                      ),
                      Text("Rs"+widget.produt.get('Total Price').toString()+"/-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 3,
                    height: 5,
                  ),
                    Text("Thank you!" ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(
                      255, 43, 72, 101)),)
                ],
              ),
            ),
          ),
        ),
      ),

      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Row(
      //       children: [
      //         SizedBox(
      //             height:150,
      //             width: 150,
      //             child: Image.asset("assets/Tritan.png")),
      //         SizedBox(
      //           width: 15,
      //         ),
      //         Column(
      //           children: [
      //             Row(
      //               children: [
      //                 Text("Tritan Bikes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),textAlign: TextAlign.start,),
      //               ],
      //             ),
      //             Text("102 Suryavihar Building\nService Road , Pancphkhadi\nThane – 400602\nE-mail – tritanbikes@gmail.com")
      //
      //           ],
      //         ),
      //        ]
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     Row(
      //       children: [
      //         Column(
      //           children: [
      //             Row(
      //               children: [
      //                 Text("Order Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 Text(widget.produt.get('Area',),textAlign: TextAlign.left,),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 Text(widget.produt.get('City')),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 Text(widget.produt.get('Pincode')),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 Text(widget.produt.get('State')),
      //               ],
      //             ),
      //
      //           ],
      //         ),
      //
      //         Column(
      //           children: [
      //             Row(
      //               children: [
      //                 Text("Delivery Addrese",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 Text(widget.produt.get('Area',),textAlign: TextAlign.left,),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 Text(widget.produt.get('City')),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 Text(widget.produt.get('Pincode')),
      //               ],
      //             ),
      //             Row(
      //               children: [
      //                 Text(widget.produt.get('State')),
      //               ],
      //             ),
      //
      //           ],
      //         ),
      //
      //           ],
      //     ),
      //   ],
      // ),

    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled13/Deatailee.dart';
import 'package:untitled13/muorder.dart';

import 'murent.dart';

class RentOrder extends StatefulWidget {
  @override
  State<RentOrder> createState() => _RentOrderState();
}
class _RentOrderState extends State<RentOrder> {
  late User? user;
  late final Stream<QuerySnapshot> orderStream;
  late CollectionReference addcart;
  @override
  void initState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    user = auth.currentUser;
    orderStream = FirebaseFirestore.instance
        .collection('usersell')
        .doc(user?.uid)
        .collection("Rent_orderr")
        .snapshots();
    addcart = FirebaseFirestore.instance.collection('Rent_orderr');
    super.initState();
  }
  // const ProductList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream:orderStream,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot) {
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) async {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Scaffold(
              appBar: AppBar(
                title:   Text('Rent Order ', textAlign: TextAlign.center,
                    style:GoogleFonts.aleo(textStyle: TextStyle(color: Colors.white))),
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor:  Color.fromARGB(255,0 , 18, 50),


              ),

              body: Center(
                  child:snapshot.data!.docs.length==0?
                  const Text('You have not done order!',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),):
                  ListView.builder(
                      itemCount:   snapshot.data!.docs.length,

                      itemBuilder: (context,index){
                        final  produt = snapshot.data!.docs[index];

                        return Container(


                          child: Card(

                            child:

                            ListTile(

                              leading: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: 50,
                                    minHeight: 260,
                                    maxWidth: 55,
                                    maxHeight: 264
                                ),
                                child:Text('#',style: TextStyle(fontSize: 30,color:  Color.fromARGB(255,0 , 18, 50),),),),
                              title:
                              Text('Order Id', style: GoogleFonts.signika(textStyle: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold,color: Color.fromARGB(255,0 , 18, 50) )),),

                              subtitle: Text(produt.get('ide').toString(),style: TextStyle(fontSize: 15),),
                              //   trailing: Text('Rs '+product.get('date').+'/-',style: TextStyle(fontSize: 15),),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>RentDetails(produt) ));
                              },

                            ),

                          ),


                        );


                      })


              )

          );
        }
    );
  }


}



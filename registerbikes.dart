import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';
import 'models.dart';
class Regisbikes extends StatefulWidget {
  const Regisbikes({Key? key}) : super(key: key);
  @override
  State<Regisbikes> createState() => _RegisbikesState();
}
class _RegisbikesState extends State<Regisbikes> {
  final _formKey =GlobalKey<FormState>();
  final TextEditingController emailEController = new TextEditingController();

  final TextEditingController phoneEController = new TextEditingController();
  final TextEditingController passwordEController = new TextEditingController();

  final TextEditingController cpasswordEController = new TextEditingController();
  final _auth =FirebaseAuth.instance;
  void register(String email ,String password)  async{
    if(_formKey.currentState!.validate()){
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        postDetailsToFirestore()
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      }
      );
    }
  }

  postDetailsToFirestore()async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user =_auth.currentUser;
    UserModel userModel=UserModel(eamil: null,phone: null);
    userModel.email=user !.email;
    userModel.uid=user .uid;
    userModel.phone=phoneEController.text;



    await firebaseFirestore
        .collection('userbike')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created:)");
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);

  }


  @override
  Widget build(BuildContext context) {


    final emailEFeild= TextFormField(
      autofocus: false,
      controller: emailEController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value){
        emailEController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),

    );
    final phoneEFeild= TextFormField(
      autofocus: false,
      controller: phoneEController,
      keyboardType: TextInputType.phone,
      onSaved: (value){
        phoneEController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.call),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),

    );
    final passwordEFeild= TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordEController,

      onSaved: (value){
        passwordEController.text=value!;
      },
      textInputAction: TextInputAction.done,


      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );
    final cpasswordEFeild= TextFormField(
      autofocus: false,
      obscureText: true,
      controller: cpasswordEController,

      onSaved: (value){
        cpasswordEController.text=value!;
      },
      textInputAction: TextInputAction.done,


      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      validator: (value){
        if(cpasswordEController.text.length>6 && passwordEController.text!=value){

          return ("password not match");
        }
        return null;
      },
    );
    final signup =Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(40),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          register(emailEController.text, passwordEController.text);

        },
        child: Text('Sign Up',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
      ),

    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    emailEFeild,
                    SizedBox(
                      height: 30,
                    ),
                    phoneEFeild,
                    SizedBox(
                      height: 30,
                    ),
                    passwordEFeild,
                    SizedBox(
                      height: 30,
                    ),
                    cpasswordEFeild,
                    SizedBox(
                      height: 30,
                    ),
                    signup,
                    SizedBox(
                      height: 30,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}

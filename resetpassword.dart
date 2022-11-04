import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled13/pri/Terms.dart';
import 'package:untitled13/sellpanel.dart';
import 'login.dart';
import 'models.dart';
class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);
  @override
  State<Reset> createState() => _ResetState();
}
class _ResetState extends State<Reset> {
  bool value=false;
  final _formKey =GlobalKey<FormState>();
  final TextEditingController emailEController = new TextEditingController();

  final TextEditingController phoneEController = new TextEditingController();
  final TextEditingController passwordEController = new TextEditingController();
  final TextEditingController checkController = new TextEditingController();
  final TextEditingController cpasswordEController = new TextEditingController();
  final _auth =FirebaseAuth.instance;
  void reset(String email )  async{

    if(_formKey.currentState!.validate()){
      await _auth.sendPasswordResetEmail(email: email).then((value) => {
      Fluttertoast.showToast(msg: 'Reset password mail is sent to your mail'),
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login() ))
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      }
      );

    }
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
          prefixIcon: const Icon(Icons.email),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )

      ),
      validator: (value){
        if(value==null||value.isEmpty)
        {
          return "Enter your email";
        }
        return null;
      },



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
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
      validator: (value){
        if(value==null||value.isEmpty)
        {
          return "Enter your password";
        }
        return null;
      },

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
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
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
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){

          reset(emailEController.text);
        },
        child: const Text('Reset Password',textAlign: TextAlign.center,style: const TextStyle(fontSize: 20),),
      ),
    );

    return Scaffold(
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
                        height: 156,
                        width: 150,
                        child: Image.asset("assets/Tritan-removebg-preview (1).png")),
                    const SizedBox(
                      height: 16,
                    ),
                    emailEFeild,

                    //phoneEFeild,

                    const SizedBox(
                      height: 30,
                    ),
                    signup,
                    const SizedBox(
                      height: 30,
                    ),

                    //Checkbox
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

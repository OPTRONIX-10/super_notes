import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/screens/email_verification.dart';
import 'package:new_project/screens/home_screens/widgets/routes.dart';
import 'package:new_project/screens/login_page.dart';

import 'home_screens/widgets/errordialod.dart';

class SignUp extends StatefulWidget {
 SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

late  TextEditingController _email;
late  TextEditingController _password;
ValueNotifier<bool> _passtext = ValueNotifier(true);

class _SignUpState extends State<SignUp> {

  @override
  void initState() {
    _email = TextEditingController();
   _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text('Sign up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 35, 10, 0),
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return('Empty Field!');
                      }else{
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      hintText: 'Email',
                      
                    )
                  ),
                ),
                const SizedBox(height: 25,),
                
                ValueListenableBuilder(valueListenable: _passtext, 
                builder:((BuildContext context, bool newpass, Widget?_) {
                  return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextFormField(
                    controller: _password,
                    obscureText: _passtext.value,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return('Empty Field!');
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      hintText: 'Passsword',
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(onPressed: (){
                        _passtext.value = !_passtext.value;
                      }, icon: Icon(_passtext.value ? Icons.visibility_off : Icons.visibility))
                    )
                  ),
                );
                }
                )),
                
                SizedBox(height: 25,),
                SizedBox(height: 55,width: 370,
                  child: ElevatedButton(onPressed: ()async{
                    final email = _email.text;
                    final password = _password.text;
                    try{
                      if(formkey.currentState!.validate()){
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, 
                      password: password);
                      final user =  FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                      Navigator.of(context).pushNamed(emailverificationroute);
                      }
                      
                    }on FirebaseAuthException catch(e){
                      if(e.code=='invalid-email'){
                        ScaffoldMessenger.of(context).showSnackBar(
                          ErrorDialog().Showerrordialog(context, 'Invalid Email'));
                        
                      }else if (e.code == 'weak-password'){
                       ScaffoldMessenger.of(context).showSnackBar(
                          ErrorDialog().Showerrordialog(context, 'Weak Password'));
                        
                      }else if(e.code == 'email-already-in-use'){
                       ScaffoldMessenger.of(context).showSnackBar(
                          ErrorDialog().Showerrordialog(context, 'Email already exists'));
                        
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          ErrorDialog().Showerrordialog(context, 'Something went wrong'));
                      }
          
                    }
                    catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(
                          ErrorDialog().Showerrordialog(context, e.toString()));
                    }
                      
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black)
                    ))
                  ), 
                  child: const Text('Sign up',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    
                  ),),)),
                      const SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text("Already have an account?",style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 109, 109, 109)),),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                }, 
                child: const Text('Login',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.teal),))
              ],)
              ],
            ),
          ),
        )
         
      );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_project/services/auth/auth_exception.dart';

import 'package:new_project/services/auth/bloc/auth_bloc.dart';
import 'home_screens/widgets/errordialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final _signinformkey = GlobalKey<FormState>();
late TextEditingController _email;
late TextEditingController _password;
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateRegistering) {
          if (state.exception is InvalidEmailAuthException) {
            ScaffoldMessenger.of(context).showSnackBar(
                ErrorDialog().Showerrordialog(context, 'Invalid Email'));
          } else if (state.exception is WeakPasswordAuthException) {
            ScaffoldMessenger.of(context).showSnackBar(
                ErrorDialog().Showerrordialog(context, 'Weak Password'));
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            ScaffoldMessenger.of(context).showSnackBar(
                ErrorDialog().Showerrordialog(context, 'Email already exists'));
          } else if (state.exception is GenericAuthException) {
            ScaffoldMessenger.of(context).showSnackBar(
                ErrorDialog().Showerrordialog(context, 'Something went wrong'));
          }
        }
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Form(
              key: _signinformkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 35, 10, 0),
                      child: TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('Empty Field!');
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            hintText: 'Email',
                          )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ValueListenableBuilder(
                        valueListenable: _passtext,
                        builder:
                            ((BuildContext context, bool newpass, Widget? _) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextFormField(
                                controller: _password,
                                obscureText: _passtext.value,
                                enableSuggestions: false,
                                autocorrect: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ('Empty Field!');
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    hintText: 'Passsword',
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          _passtext.value = !_passtext.value;
                                        },
                                        icon: Icon(_passtext.value
                                            ? Icons.visibility_off
                                            : Icons.visibility)))),
                          );
                        })),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                        height: 55,
                        width: 370,
                        child: ElevatedButton(
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;

                            if (_signinformkey.currentState!.validate()) {
                              context.read<AuthBloc>().add(AuthEventRegister(
                                  email: email, password: password));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 109, 109, 109)),
                        ),
                        TextButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthEventLogout());
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

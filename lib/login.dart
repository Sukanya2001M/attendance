import 'package:attendance/signupwithgoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:get/get.dart';
import 'home.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final TextEditingController useremailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Create a global key to identify the Form widget and validate the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: GlassmorphicContainer(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 500,
            borderRadius: 20,
            blur: 15,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.white.withOpacity(0.1),
              ],
              stops: [0.1, 1],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.1),
                Colors.transparent,
                Colors.transparent,
              ],
              stops: [0.1, 0.3, 0.8, 1],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey, // Assign the form key here
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 135, 119, 119)
                            .withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: useremailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: const Color.fromARGB(255, 135, 119, 119)
                              .withOpacity(0.8),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Color.fromARGB(255, 135, 119, 119)
                              .withOpacity(0.8),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () async {
                        String email = useremailController.text.trim();
                        String password = passwordController.text.trim();

                        if (email.isNotEmpty && password.isNotEmpty) {
                          try {
                            // Sign up the user with email and password
                            UserCredential userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            // Navigate to the Profile screen after successful sign-up
                            Get.to(() => Home());

                            print("User signed up: ${userCredential.user?.email}");
                          } catch (e) {
                            // Handle errors such as invalid email or weak password
                            print("Error during sign-up: $e");
                            Get.snackbar(
                              "Sign-Up Error",
                              e.toString(),
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        } else {
                          // Show a warning if email or password fields are empty
                          Get.snackbar(
                            "Invalid Input",
                            "Email and password cannot be empty",
                            backgroundColor: Colors.orange,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 185, 164, 164).withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // const SizedBox(height: ),
                    ElevatedButton(
                      onPressed: () async {
                        final user = await signInWithGoogle();
                        // if (user != null) {
                        //   print("User signed in: ${user.email}");
                        // }
                      },
                      child: Text("Sign in with Google"),
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

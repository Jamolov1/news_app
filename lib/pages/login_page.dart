import 'package:flutter/material.dart';
import 'package:news_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void login() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const HomePage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height * 0.06;
    final double width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: size.height * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello",
                  style: TextStyle(
                    color: const Color(0xFF050505),
                    fontSize: size.width * 0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Again!",
                  style: TextStyle(
                    color: const Color(0xFF1877F2),
                    fontSize: size.width * 0.12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  "Welcome back you've \nbeen missed",
                  style: TextStyle(
                    color: const Color(0xFF4E4B66),
                    fontSize: size.width * 0.05,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                _buildInputField("UserName", _userName, false, "Invalid UserName", height),
                SizedBox(height: size.height * 0.02),
                _buildInputField("Password", _password, true, "Password must be at least 6 characters", height),
                SizedBox(height: size.height * 0.04),
                InkWell(
                  onTap: login,
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1877F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                _buildSocialButtons(height),
                SizedBox(height: size.height * 0.02),
                _buildSignUpText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, bool obscureText, String errorMsg, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.5, color: Colors.grey),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: (value) => value!.isEmpty ? errorMsg : null,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons(double height) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: height,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/facebook.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  "Facebook",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: height,
            margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/google.png"),
                    ),
                  ),
                ),
                Text(
                  "Google",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpText() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account? ", style: TextStyle(color: Color(0xFF4E4B66))),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Color(0xFF1877F2), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

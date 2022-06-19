import 'package:campusapp/HomePageStaff.dart';
import 'package:campusapp/userPreferences.dart';
import 'package:flutter/material.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isPasswordVisible = true;
  final userNameController = TextEditingController();
  var password = '';
  String? errorPassword;
  String? errorUsername;
  @override
  void initState() {
    super.initState();
    userNameController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Stack(
          children:[
            Container(
              width: 500,
              child: Image.asset('assets/Images/starterScreen.png',fit: BoxFit.fill,),
            ),
            Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black,width: 5),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
                    suffixIcon: userNameController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () => userNameController.clear(),
                            icon: const Icon(Icons.close)),
                    errorText: errorUsername,
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    suffixIcon: IconButton(
                      icon: isPasswordVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () =>
                          setState(() => isPasswordVisible = !isPasswordVisible),
                    ),
                    errorText: errorPassword,
                  ),
                  obscureText: isPasswordVisible,
                  onSubmitted: (value) => setState(() {
                    password = value;
                  }),
                 onChanged: (value) => setState(() {
                   password = value;
                  }),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  fixedSize: const Size(120, 50)
                ),
                  onPressed: () {
                    if (userNameController.text == 'staffmember' &&
                        password == 'gc11staff') {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      currentFocus.unfocus();
                      userPreferences.setUser('staff');
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomePageStaff(),), (route) => false);
                    } else if(userNameController.text != 'staffmember'&&password != 'gc11staff'){
                      setState(() {
                        errorUsername = 'Worng Username';
                        errorPassword = 'Worng Password';
                      });
                    } else if (userNameController.text != 'staffmember') {
                      setState(() {
                        errorUsername = 'Worng Username';
                      });
                    } else if (password != 'gc11staff') {
                      setState(() {
                        errorPassword = 'Worng Password';
                      });
                    }
                  },
                  child: const Text('Submit',style: TextStyle(fontSize: 18),))
            ],
          ),
    ],
        ),
      ),
    );
  }
}
